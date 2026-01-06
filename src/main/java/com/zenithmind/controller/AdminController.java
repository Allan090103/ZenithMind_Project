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
