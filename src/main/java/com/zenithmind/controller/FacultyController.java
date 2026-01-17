package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/faculty")
public class FacultyController {

    @Autowired
    private UserService userService;

    private void setupFacultyContext(String role, Model model, HttpSession session, java.security.Principal principal) {
        String username = principal != null ? principal.getName() : "guest";
        Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase(role)) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Navigation links
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("trainingLink", "/faculty/training?" + roleSuffix);
        model.addAttribute("guidesLink", "/faculty/guides?" + roleSuffix);
        model.addAttribute("reportLink", "/faculty/report?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);
    }

    @GetMapping("/training")
    public String training(@RequestParam(required = false, defaultValue = "faculty") String role,
            @RequestParam(required = false) String section,
            Model model, HttpSession session, java.security.Principal principal) {
        setupFacultyContext(role, model, session, principal);
        model.addAttribute("activeSection", "training");

        String username = principal != null ? principal.getName() : "guest";

        // Define Training Modules
        java.util.List<String[]> trainingModules = new java.util.ArrayList<>();
        trainingModules.add(new String[] { "Identifying Student Distress",
                "Learn to recognize academic, physical, and behavioral signs of distress in students.", "20 min",
                "Not Started", "identifying-distress" });
        trainingModules.add(new String[] { "Crisis Response Protocol",
                "Understand the immediate steps to take during a student mental health crisis.", "25 min",
                "Not Started", "crisis-response" });
        trainingModules.add(new String[] { "Inclusive Teaching Practices",
                "Strategies to create a supportive and psychologically safe learning environment.", "30 min",
                "Not Started", "inclusive-teaching" });
        trainingModules.add(new String[] { "Self-Care for Educators",
                "Techniques for managing burnout and maintaining your own well-being.", "15 min", "Not Started",
                "self-care-educators" });

        // Fetch Progress
        java.util.Map<String, java.util.Map<String, Object>> progressMap = userService
                .getFacultyTrainingProgress(username);
        int completedCount = 0;

        for (int i = 0; i < trainingModules.size(); i++) {
            String[] m = trainingModules.get(i);
            String slug = m[4];
            if (progressMap.containsKey(slug)) {
                java.util.Map<String, Object> p = progressMap.get(slug);
                String status = (String) p.get("status");
                if ("done".equals(status)) {
                    m[3] = "Completed";
                    completedCount++;
                } else if ("progress".equals(status)) {
                    m[3] = "In Progress";
                }
            }
        }

        int progressPercent = (int) Math.round(((double) completedCount / trainingModules.size()) * 100);

        model.addAttribute("trainingModules", trainingModules);
        model.addAttribute("completedCount", completedCount);
        model.addAttribute("totalModules", trainingModules.size());
        model.addAttribute("progressPercent", progressPercent);

        return "faculty-training";
    }

    @PostMapping("/training/progress")
    public String handleTrainingProgress(@RequestParam String module,
            @RequestParam String action,
            @RequestParam(required = false, defaultValue = "faculty") String role,
            java.security.Principal principal) {

        String username = principal != null ? principal.getName() : "guest";
        String status = "progress";
        int currentSection = 1;

        if ("finish".equals(action)) {
            status = "done";
            currentSection = 5; // Assume max for now
            userService.updateUserPoints(username, 50);
        } else if ("start".equals(action)) {
            status = "progress";
            currentSection = 1;
        }

        userService.saveFacultyTrainingProgress(username, module, currentSection, status);

        return "redirect:/faculty/training?role=" + role;
    }

    @GetMapping("/guides")
    public String guides(@RequestParam(required = false, defaultValue = "faculty") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        setupFacultyContext(role, model, session, principal);
        model.addAttribute("activeSection", "guides");
        return "faculty-guides";
    }

    @GetMapping("/report")
    public String reportForm(@RequestParam(required = false, defaultValue = "faculty") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        setupFacultyContext(role, model, session, principal);
        model.addAttribute("activeSection", "report");
        return "faculty-report";
    }

    @PostMapping("/report/submit")
    public String submitReport(@RequestParam String studentName,
            @RequestParam String concernType,
            @RequestParam String description,
            @RequestParam String urgency,
            @RequestParam(required = false, defaultValue = "faculty") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        setupFacultyContext(role, model, session, principal);
        model.addAttribute("activeSection", "report");
        model.addAttribute("submitted", true);
        model.addAttribute("confirmationId", "REF-" + System.currentTimeMillis());
        return "faculty-report";
    }
}
