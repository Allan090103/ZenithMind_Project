package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @GetMapping("/panel")
    public String adminPanel(Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData("admin");
        model.addAllAttributes(userData);

        // Ensure session user is set
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), "admin", 150);
            session.setAttribute("user", user);
        }

        // Links
        String roleSuffix = "role=admin";
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);

        return "admin/admin_panel";
    }

    @GetMapping("/users")
    public String userManagement(Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData("admin");
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), "admin", 150);
            session.setAttribute("user", user);
        }

        // Fetch all users and filter out admin
        java.util.List<Map<String, Object>> allUsers = userService.getAllUsers();
        java.util.List<Map<String, Object>> filteredUsers = new java.util.ArrayList<>();

        for (Map<String, Object> u : allUsers) {
            String role = (String) u.get("role");
            // Exclude admin role
            if (!"admin".equalsIgnoreCase(role)) {
                filteredUsers.add(u);
            }
        }

        model.addAttribute("userList", filteredUsers);
        model.addAttribute("totalUsersCount", allUsers.size()); // Total including admin potentially?
        // Actually, the UI says "Showing 5 of 1,247 users".
        // usage: Showing ${userList.size()} of ${totalUsersCount} users

        String roleSuffix = "role=admin";
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);

        return "admin/user_management";
    }

    @GetMapping("/analytics")
    public String platformAnalytics(Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData("admin");
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), "admin", 150);
            session.setAttribute("user", user);
        }

        String roleSuffix = "role=admin";
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);

        // Fetch stats
        int totalUsers = userService.getTotalUserCount();
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("activeUsers", totalUsers);

        java.util.Map<String, Integer> analytics = userService.getPlatformAnalytics();
        model.addAttribute("modulesCompleted", analytics.getOrDefault("modulesCompleted", 0));
        model.addAttribute("forumPosts", analytics.getOrDefault("forumPosts", 0));

        return "admin/platform_analytics";
    }

    @GetMapping("/moderation")
    public String contentModeration(Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData("admin");
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), "admin", 150);
            session.setAttribute("user", user);
        }

        String roleSuffix = "role=admin";
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);

        return "admin/content_moderation";
    }

    @GetMapping("/settings")
    public String profileSettings(Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData("admin");
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), "admin", 150);
            session.setAttribute("user", user);
        }

        String roleSuffix = "role=admin";
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);

        return "admin/profile_settings";
    }
}
