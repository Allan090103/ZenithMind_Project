package com.zenithmind.controller;

import com.zenithmind.model.ModuleContent;
import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
            Model model, HttpSession session) {

        // Populate User Data
        Map<String, Object> userData = userService.getUserData(role);
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
                "Learn techniques to manage daily stress and build healthy routines.", "15 min", 50, 100, "done",
                "Review", "✅",
                new String[] { "Introduction to Stress", "Identifying Triggers", "Coping Strategies",
                        "Daily Routine Reset", "Knowledge Check" },
                5));
        modules.add(new ModuleContent(
                "understanding-anxiety", "Understanding Anxiety",
                "Learn about anxiety, its causes, symptoms, and effective coping strategies.", "20 min", 75, 60,
                "progress", "Continue", "📘",
                new String[] { "Introduction to Anxiety", "Types of Anxiety Disorders", "Symptoms and Signs",
                        "Coping Strategies", "Quiz" },
                1));
        modules.add(new ModuleContent(
                "depression-awareness", "Depression Awareness",
                "Recognize signs, risk factors, and when to seek help.", "25 min", 100, 0, "locked", "Start", "🔒",
                new String[] { "What is Depression?", "Signs and Symptoms", " Causes and Risk Factors",
                        "Treatment Options", "Helping Others" },
                0));
        modules.add(new ModuleContent(
                "mindfulness-basics", "Mindfulness Basics",
                "Introduction to mindfulness meditation and practice.", "10 min", 50, 0, "locked", "Start", "🔒",
                new String[] { "What is Mindfulness?", "Breathing Techniques", "Body Scan", "Daily Practice" }, 0));

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

        model.addAttribute("currentSection", section);

        return "modules";
    }
}
