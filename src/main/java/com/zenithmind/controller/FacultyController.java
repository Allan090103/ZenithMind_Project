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
    }

    @GetMapping("/training")
    public String training(@RequestParam(required = false, defaultValue = "faculty") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        setupFacultyContext(role, model, session, principal);
        model.addAttribute("activeSection", "training");
        return "faculty-training";
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
