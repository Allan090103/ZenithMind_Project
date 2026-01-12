package com.zenithmind.controller;

import com.zenithmind.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private RegistrationService registrationService;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register";
    }

    @PostMapping("/register")
    public String registerStudent(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("name") String name,
            @RequestParam(value = "email", required = false) String email,
            Model model) {

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                name == null || name.trim().isEmpty()) {
            model.addAttribute("error", "Username, password, and name are required");
            return "register";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters long");
            return "register";
        }

        // Attempt registration
        boolean success = registrationService.registerStudent(username, password, name, email);

        if (success) {
            // Redirect to login with success message
            return "redirect:/login?registered";
        } else {
            model.addAttribute("error", "Username already exists. Please choose a different username.");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(javax.servlet.http.HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout";
    }
}
