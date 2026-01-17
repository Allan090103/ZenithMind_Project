package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/professional")
public class ProfessionalController {

    @Autowired
    private UserService userService;

    private void setupProfessionalContext(String role, Model model, HttpSession session) {
        Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase(role)) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Navigation links
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("casesLink", "/professional/cases?" + roleSuffix);
        model.addAttribute("telehealthLink", "/professional/telehealth?" + roleSuffix);
        model.addAttribute("monitoringLink", "/professional/monitoring?" + roleSuffix);
        model.addAttribute("resourcesLink", "/professional/resources?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);
    }

    @GetMapping("/cases")
    public String caseManagement(@RequestParam(required = false, defaultValue = "professional") String role,
            Model model, HttpSession session) {
        setupProfessionalContext(role, model, session);
        model.addAttribute("activeSection", "cases");
        return "case-management";
    }

    @GetMapping("/telehealth")
    public String telehealth(@RequestParam(required = false, defaultValue = "professional") String role,
            Model model, HttpSession session, java.security.Principal principal) {
        setupProfessionalContext(role, model, session);
        model.addAttribute("activeSection", "telehealth");

        if (principal != null) {
            String username = principal.getName();
            System.out.println("DEBUG: ProfessionalController - Logged in as: " + username);

            // Fetch real appointments
            java.util.List<Map<String, Object>> appts = userService.getAppointmentsForCounselor(username);
            System.out.println("DEBUG: ProfessionalController - Appointments found: " + appts.size());

            // Transform to List<String[]> as expected by JSP
            java.util.List<String[]> formattedAppts = new java.util.ArrayList<>();
            for (Map<String, Object> a : appts) {
                formattedAppts.add(new String[] {
                        (String) a.get("appt_time"),
                        (String) a.get("student_name"),
                        (String) a.get("type"),
                        (String) a.get("status"),
                        a.get("appt_date").toString()
                });
            }
            model.addAttribute("appointments", formattedAppts);
        }
        return "telehealth";
    }

    @GetMapping("/monitoring")
    public String patientMonitoring(@RequestParam(required = false, defaultValue = "professional") String role,
            Model model, HttpSession session) {
        setupProfessionalContext(role, model, session);
        model.addAttribute("activeSection", "monitoring");
        return "patient-monitoring";
    }

    @GetMapping("/resources")
    public String resources(@RequestParam(required = false, defaultValue = "professional") String role,
            Model model, HttpSession session) {
        setupProfessionalContext(role, model, session);
        model.addAttribute("activeSection", "resources");
        return "resources";
    }
}
