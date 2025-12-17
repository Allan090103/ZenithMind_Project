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
public class MoodController {

    @Autowired
    private UserService userService;

    @GetMapping("/mood")
    public String mood(@RequestParam(required = false, defaultValue = "student") String role,
            Model model, HttpSession session) {

        Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "forum");
        model.addAttribute("moodLink", "mood?" + roleSuffix);
        model.addAttribute("supportLink", "support?" + roleSuffix);

        return "mood";
    }
}
