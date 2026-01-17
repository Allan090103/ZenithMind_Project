package com.zenithmind.controller;

import com.zenithmind.model.ModuleContent;
import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ModuleController {

    @Autowired
    private UserService userService;

    @GetMapping("/modules")
    public String modules(@RequestParam(required = false, defaultValue = "student") String role,
            @RequestParam(required = false) String section,
            @RequestParam(required = false) String module,
            Model model, HttpSession session, java.security.Principal principal) {

        // Get authenticated username
        String username = principal != null ? principal.getName() : "guest";

        // Fetch user data based on authenticated username
        Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        // Ensure session user
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Generate Modules
        List<ModuleContent> modules = new ArrayList<>();
        modules.add(new ModuleContent(
                "stress-management", "Stress Management",
                "Learn techniques to manage daily stress and build healthy routines.", "15 min", 50, 0, "start",
                "Start", "🧘",
                new String[] { "Introduction to Stress", "Identifying Triggers", "Coping Strategies",
                        "Daily Routine Reset", "Knowledge Check" },
                1));
        modules.add(new ModuleContent(
                "understanding-anxiety", "Understanding Anxiety",
                "Learn about anxiety, its causes, symptoms, and effective coping strategies.", "20 min", 75, 0,
                "start", "Start", "📘",
                new String[] { "Introduction to Anxiety", "Types of Anxiety Disorders", "Symptoms and Signs",
                        "Coping Strategies", "Quiz" },
                1));
        modules.add(new ModuleContent(
                "depression-awareness", "Depression Awareness",
                "Recognize signs, risk factors, and when to seek help.", "25 min", 100, 0, "start", "Start", "☀️",
                new String[] { "What is Depression?", "Signs and Symptoms", " Causes and Risk Factors",
                        "Treatment Options", "Helping Others" },
                1));
        modules.add(new ModuleContent(
                "mindfulness-basics", "Mindfulness Basics",
                "Introduction to mindfulness meditation and practice.", "10 min", 50, 0, "start", "Start", "🌿",
                new String[] { "What is Mindfulness?", "Breathing Techniques", "Body Scan", "Daily Practice" }, 1));

        // Fetch saved progress from DB
        Map<String, Map<String, Object>> progressMap = userService.getAllModuleProgress(username);

        // Update modules with saved progress
        for (ModuleContent m : modules) {
            if (progressMap.containsKey(m.getSlug())) {
                Map<String, Object> progressData = progressMap.get(m.getSlug());
                String status = (String) progressData.get("status");
                int currentSec = (Integer) progressData.get("current_section");

                m.setStatus(status);
                m.setCurrentSection(currentSec);

                // Calculate progress percentage
                int totalSections = m.getSections().length;
                int percent = (int) Math.round(((double) (currentSec - 1) / totalSections) * 100);
                if ("done".equals(status)) {
                    percent = 100;
                    m.setButtonLabel("Review");
                } else if ("start".equals(status)) {
                    percent = 0;
                    m.setButtonLabel("Start");
                } else {
                    m.setButtonLabel("Continue");
                }
                m.setProgress(percent);
            }
        }

        // Calculate counts
        int completedCount = 0;
        int inProgressCount = 0;
        for (ModuleContent m : modules) {
            if ("done".equals(m.getStatus()))
                completedCount++;
            else if ("progress".equals(m.getStatus()))
                inProgressCount++;
        }
        model.addAttribute("completedCount", completedCount);
        model.addAttribute("inProgressCount", inProgressCount);

        model.addAttribute("modules", modules);

        // Active Module Logic
        ModuleContent activeModule = null;
        if (module != null) {
            for (ModuleContent m : modules) {
                if (m.getSlug().equals(module)) {
                    activeModule = m;
                    break;
                }
            }
        }
        model.addAttribute("activeModule", activeModule);
        model.addAttribute("showDetail", activeModule != null);

        // Links
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "/modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "/modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "/self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("moodLink", "/mood?" + roleSuffix);
        model.addAttribute("supportLink", "/support?" + roleSuffix);
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);

        model.addAttribute("currentSection", section);

        return "modules";
    }

    @PostMapping("/modules/progress")
    public String handleModuleProgress(@RequestParam String module,
            @RequestParam String action,
            @RequestParam(required = false, defaultValue = "student") String role,
            java.security.Principal principal) {

        String username = principal != null ? principal.getName() : "guest";

        // Get current progress or default
        Map<String, Object> currentProgress = userService.getModuleProgress(username, module);
        int currentSection = 1;
        String status = "start";

        if (currentProgress != null) {
            currentSection = (Integer) currentProgress.get("current_section");
            status = (String) currentProgress.get("status");
        }

        // Determine max sections (Hardcoded for now as we don't have a DB of modules
        // unique by slug easily accessible here without duplicating logic.
        // ideally ModuleContent should be in DB too. For now, we will assume 5 as rough
        // max or fetch from a helper)
        // BETTER: Retrieve the specific module to get its section count.
        int totalSections = 5; // Default safety
        // Re-find the module to get accurate section count
        List<ModuleContent> allModules = getAllModules();
        for (ModuleContent m : allModules) {
            if (m.getSlug().equals(module)) {
                totalSections = m.getSections().length;
                break;
            }
        }

        if ("next".equals(action)) {
            if (currentSection < totalSections) {
                currentSection++;
                status = "progress";
            }
        } else if ("prev".equals(action)) {
            if (currentSection > 1) {
                currentSection--;
            }
        } else if ("finish".equals(action)) {
            status = "done";
            currentSection = totalSections; // Ensure we stick to end
            // Award points if first time completing? Logic can be added here.
            userService.updateUserPoints(username, 50); // Award 50 points for completion
        } else if ("start".equals(action)) {
            status = "progress";
            currentSection = 1;
        }

        userService.saveModuleProgress(username, module, currentSection, status);

        if ("done".equals(status)) {
            return "redirect:/modules?role=" + role;
        } else {
            return "redirect:/modules?module=" + module + "&role=" + role;
        }
    }

    // Helper to get modules list (duplicated logic to avoid full refactor of DB
    // schema for now)
    private List<ModuleContent> getAllModules() {
        List<ModuleContent> modules = new ArrayList<>();
        modules.add(new ModuleContent(
                "stress-management", "Stress Management",
                "Learn techniques to manage daily stress and build healthy routines.", "15 min", 50, 0, "start",
                "Start", "🧘",
                new String[] { "Introduction to Stress", "Identifying Triggers", "Coping Strategies",
                        "Daily Routine Reset", "Knowledge Check" },
                1));
        modules.add(new ModuleContent(
                "understanding-anxiety", "Understanding Anxiety",
                "Learn about anxiety, its causes, symptoms, and effective coping strategies.", "20 min", 75, 0,
                "start", "Start", "📘",
                new String[] { "Introduction to Anxiety", "Types of Anxiety Disorders", "Symptoms and Signs",
                        "Coping Strategies", "Quiz" },
                1));
        modules.add(new ModuleContent(
                "depression-awareness", "Depression Awareness",
                "Recognize signs, risk factors, and when to seek help.", "25 min", 100, 0, "start", "Start", "☀️",
                new String[] { "What is Depression?", "Signs and Symptoms", " Causes and Risk Factors",
                        "Treatment Options", "Helping Others" },
                1));
        modules.add(new ModuleContent(
                "mindfulness-basics", "Mindfulness Basics",
                "Introduction to mindfulness meditation and practice.", "10 min", 50, 0, "start", "Start", "🌿",
                new String[] { "What is Mindfulness?", "Breathing Techniques", "Body Scan", "Daily Practice" }, 1));
        return modules;
    }
}
