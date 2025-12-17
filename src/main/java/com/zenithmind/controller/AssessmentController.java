package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
public class AssessmentController {

    @Autowired
    private UserService userService;

    // Data Structures
    private static final Map<String, AssessmentType> ASSESSMENT_TYPES = new LinkedHashMap<>();

    static {
        ASSESSMENT_TYPES.put("stress", new AssessmentType(
                "Stress Assessment",
                "Evaluate your current stress levels",
                "😰",
                new String[] {
                        "Felt nervous or stressed",
                        "Unable to control important things",
                        "Felt confident handling problems",
                        "Felt things were going your way",
                        "Felt difficulties piling up"
                }));
        ASSESSMENT_TYPES.put("anxiety", new AssessmentType(
                "Anxiety Screening",
                "Assess anxiety symptoms",
                "😟",
                new String[] {
                        "Feeling nervous or anxious",
                        "Unable to stop worrying",
                        "Worrying too much",
                        "Trouble relaxing",
                        "Feeling restless"
                }));
        ASSESSMENT_TYPES.put("depression", new AssessmentType(
                "Depression Screening",
                "Check for depression indicators",
                "😔",
                new String[] {
                        "Little interest in activities",
                        "Feeling down or hopeless",
                        "Sleep problems",
                        "Feeling tired",
                        "Poor appetite changes"
                }));
    }

    @GetMapping("/self-assessment")
    public String selfAssessment(@RequestParam(required = false, defaultValue = "student") String role,
            @RequestParam(required = false, defaultValue = "stress") String type,
            Model model, HttpSession session) {

        // User & Sidebar Setup
        Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        addSidebarLinks(model, role);

        // Assessment Logic
        if (!ASSESSMENT_TYPES.containsKey(type)) {
            type = "stress";
        }

        model.addAttribute("selectedType", type);
        model.addAttribute("assessmentTypes", ASSESSMENT_TYPES);
        model.addAttribute("currentAssessment", ASSESSMENT_TYPES.get(type));

        return "self-assessment";
    }

    @PostMapping("/self-assessment/submit")
    public String submitAssessment(@RequestParam String role,
            @RequestParam String type,
            @RequestParam Map<String, String> allParams,
            Model model, HttpSession session) {

        // Restore Context
        Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);
        addSidebarLinks(model, role);

        if (!ASSESSMENT_TYPES.containsKey(type))
            type = "stress";
        AssessmentType assessment = ASSESSMENT_TYPES.get(type);

        // Calculate Score
        int totalScore = 0;
        int maxScore = assessment.questions.length * 3;
        int answeredCount = 0;

        for (int i = 0; i < assessment.questions.length; i++) {
            String val = allParams.get("q" + i);
            if (val != null) {
                totalScore += Integer.parseInt(val);
                answeredCount++;
            }
        }

        int percentage = (int) Math.round(((double) totalScore / maxScore) * 100);

        // Determine Severity
        String severityLevel;
        String severityColor;
        String severityUnsafeColor; // For text/bg usage
        String severityDesc;

        if (percentage < 25) {
            severityLevel = "Minimal";
            severityColor = "bg-green-500";
            severityUnsafeColor = "green";
            severityDesc = "You are experiencing minimal symptoms. Keep up healthy habits!";
        } else if (percentage < 50) {
            severityLevel = "Mild";
            severityColor = "bg-yellow-500";
            severityUnsafeColor = "yellow";
            severityDesc = "You are experiencing mild symptoms. Self-care strategies may help.";
        } else if (percentage < 75) {
            severityLevel = "Moderate";
            severityColor = "bg-orange-500";
            severityUnsafeColor = "orange";
            severityDesc = "You are experiencing moderate symptoms. Consider professional support.";
        } else {
            severityLevel = "Severe";
            severityColor = "bg-red-500";
            severityUnsafeColor = "red";
            severityDesc = "You are experiencing severe symptoms. We recommend seeking professional help.";
        }

        model.addAttribute("selectedType", type);
        model.addAttribute("assessmentTypes", ASSESSMENT_TYPES);
        model.addAttribute("currentAssessment", assessment);

        model.addAttribute("submitted", true);
        model.addAttribute("score", percentage);
        model.addAttribute("severityLevel", severityLevel);
        model.addAttribute("severityColor", severityColor);
        model.addAttribute("severityUnsafeColor", severityUnsafeColor);
        model.addAttribute("severityDesc", severityDesc);

        return "self-assessment";
    }

    private void addSidebarLinks(Model model, String role) {
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "forum");
        model.addAttribute("moodLink", "mood?" + roleSuffix);
        model.addAttribute("supportLink", "support?" + roleSuffix);
    }

    // Inner Class for Assessment Data
    public static class AssessmentType {
        String title;
        String description;
        String icon;
        String[] questions;

        public AssessmentType(String title, String description, String icon, String[] questions) {
            this.title = title;
            this.description = description;
            this.icon = icon;
            this.questions = questions;
        }
        
        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public String getIcon() { return icon; }
        public String[] getQuestions() { return questions; }
    }
}
