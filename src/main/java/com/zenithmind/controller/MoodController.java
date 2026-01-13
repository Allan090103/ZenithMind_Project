package com.zenithmind.controller;

import com.zenithmind.model.User;
import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class MoodController {

    @Autowired
    private UserService userService;

    // Mood score mapping
    private static final Map<String, Integer> MOOD_SCORES = Map.of(
            "great", 5,
            "good", 4,
            "okay", 3,
            "not-good", 2,
            "bad", 1);

    @GetMapping("/mood")
    public String mood(@RequestParam(required = false, defaultValue = "student") String role,
            Model model, HttpSession session, java.security.Principal principal) {

        String username = principal != null ? principal.getName() : "guest";
        Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "/modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "/modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "/self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");
        model.addAttribute("moodLink", "/mood?" + roleSuffix);
        model.addAttribute("supportLink", "/support?" + roleSuffix);

        // Load mood logs from database
        List<Map<String, Object>> moodLogs = userService.getMoodLogsByUsername(username, 10);
        model.addAttribute("moodLogs", moodLogs);

        // Load mood stats
        Map<String, Object> moodStats = userService.getMoodStats(username);
        model.addAttribute("moodStats", moodStats);

        return "mood";
    }

    @PostMapping("/mood/log")
    @ResponseBody
    public Map<String, Object> logMood(@RequestParam(required = false, defaultValue = "student") String role,
            @RequestParam String mood,
            @RequestParam(required = false) String activities,
            @RequestParam(required = false) String note,
            java.security.Principal principal) {

        Map<String, Object> response = new java.util.HashMap<>();

        try {
            String username = principal != null ? principal.getName() : "guest";

            // Get mood score
            int moodScore = MOOD_SCORES.getOrDefault(mood.toLowerCase(), 3);

            // Save mood log to database
            boolean logSaved = userService.saveMoodLog(username, mood, moodScore, activities, note);

            // Award points for logging mood
            boolean pointsUpdated = userService.updateUserPoints(username, 5);

            if (logSaved && pointsUpdated) {
                int currentPoints = userService.getUserPoints(username);

                // Get updated stats
                Map<String, Object> moodStats = userService.getMoodStats(username);

                // Get recent logs to return
                List<Map<String, Object>> recentLogs = userService.getMoodLogsByUsername(username, 4);

                response.put("success", true);
                response.put("message", "Mood logged successfully! +5 points");
                response.put("points", currentPoints);
                response.put("wellnessPercent", userService.getWellnessScore(username));
                response.put("moodStats", moodStats);
                response.put("recentLogs", recentLogs);
            } else {
                response.put("success", false);
                response.put("message", "Failed to save mood log");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error logging mood: " + e.getMessage());
        }

        return response;
    }
}
