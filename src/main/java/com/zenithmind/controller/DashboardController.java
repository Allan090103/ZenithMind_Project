package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required = false, defaultValue = "student") String role,
            Model model, HttpSession session, java.security.Principal principal) {

        // Get authenticated username from Spring Security
        String username = principal != null ? principal.getName() : "guest";

        // Fetch user data based on authenticated username
        Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        // Ensure session user is set for header/forum compatibility
        // Ensure session user matches the requested role
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase(role)) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Links
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "/modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "/modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "/self-assessment?" + roleSuffix);
        model.addAttribute("moodLink", "/mood?" + roleSuffix);
        model.addAttribute("supportLink", "/support?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);

        if ("professional".equalsIgnoreCase(role)) {
            return "professional-dashboard";
        }

        if ("faculty".equalsIgnoreCase(role)) {
            // Define Training Modules (matching FacultyController)
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

            for (String[] m : trainingModules) {
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

            return "faculty-dashboard";
        }

        // Route admin users to dedicated admin dashboard
        if ("admin".equalsIgnoreCase(role)) {
            int totalUsers = userService.getTotalUserCount();
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("activeUsers", totalUsers);

            java.util.Map<String, Integer> roleCounts = userService.getUserRoleCounts();
            model.addAttribute("studentCount", roleCounts.getOrDefault("student", 0));
            model.addAttribute("facultyCount", roleCounts.getOrDefault("faculty", 0));
            model.addAttribute("professionalCount", roleCounts.getOrDefault("professional", 0));

            java.util.Map<String, Integer> analytics = userService.getPlatformAnalytics();
            model.addAttribute("modulesCompleted", analytics.getOrDefault("modulesCompleted", 0));
            model.addAttribute("forumPosts", analytics.getOrDefault("forumPosts", 0));
            model.addAttribute("supportSessions", analytics.getOrDefault("supportSessions", 0));

            return "admin_dashboard";
        }

        return "dashboard";
    }

    @GetMapping("/profile-settings")
    public String profileSettings(@RequestParam(required = false, defaultValue = "student") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        String username = principal != null ? principal.getName() : "guest";
        Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        // Sidebar link setup (reused from dashboard)
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "/modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "/modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "/self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("moodLink", "/mood?" + roleSuffix);
        model.addAttribute("supportLink", "/support?" + roleSuffix);
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);

        if ("admin".equalsIgnoreCase(role)) {
            return "admin/profile_settings";
        }
        return "student_profile_settings";
    }
}
