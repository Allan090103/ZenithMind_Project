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
public class AssessmentController {

    @Autowired
    private UserService userService;

    @GetMapping("/self-assessment")
    public String selfAssessment(@RequestParam(required = false, defaultValue = "student") String role,
            @RequestParam(required = false, defaultValue = "stress") String category,
            Model model, HttpSession session) {

        Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Add links just in case (though header logic should ideally be standardized)
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "forum");
        model.addAttribute("moodLink", "mood?" + roleSuffix);
        model.addAttribute("supportLink", "support?" + roleSuffix);

        // Assessment Data
        String[][] categories = {
                { "stress", "Stress Assessment", "Evaluate your current stress levels", "😰" },
                { "anxiety", "Anxiety Screening", "Assess anxiety symptoms", "😟" },
                { "depression", "Depression Screening", "Check for depression indicators", "😞" }
        };

        String[] questionPrompts = {
                "Felt nervous or stressed?",
                "Unable to control important things?",
                "Felt confident handling problems?",
                "Felt things were going your way?",
                "Felt difficulties piling up?"
        };

        String[] answerOptions = { "Not at all", "Several days", "Often", "Nearly daily" };

        model.addAttribute("categories", categories);
        model.addAttribute("questionPrompts", questionPrompts);
        model.addAttribute("answerOptions", answerOptions);
        model.addAttribute("selectedCategory", category);

        return "self-assessment";
    }
}
