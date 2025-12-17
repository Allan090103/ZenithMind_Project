package com.zenithmind.service;

import com.zenithmind.model.User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {

        public Map<String, Object> getUserData(String role) {
                if (role == null)
                        role = "student";
                role = role.toLowerCase();

                Map<String, Object> data = new HashMap<>();
                String name = "Ali";
                String email = "ali@student.edu";
                String roleTitle = "Student";
                String department = "Computer Science Department";
                int score = 72;
                String improvementNote = "+5% improvement from last week";
                int modulesCompleted = 8;
                int dayStreak = 12;
                String goalDescription = "Complete 3 modules this week";
                int goalCompleted = 2;
                int goalTarget = 3;
                String goalNote = "2 of 3 completed";
                String[][] activities = {
                                { "Completed \"Stress Management\"", "2h ago" },
                                { "Logged mood check-in", "1d ago" },
                                { "Posted in community", "2d ago" }
                };
                String[][] badges = {
                                { "First Steps", "blue" },
                                { "7-Day Streak", "orange" },
                                { "Helper", "gold" }
                };

                if ("faculty".equals(role)) {
                        name = "Aiman";
                        email = "aiman@faculty.edu";
                        roleTitle = "Faculty Member";
                        department = "Psychology Department";
                        score = 86;
                        improvementNote = "+2% improvement from last week";
                        modulesCompleted = 12;
                        dayStreak = 20;
                        goalDescription = "Facilitate 2 resilience workshops";
                        goalCompleted = 1;
                        goalTarget = 2;
                        goalNote = "1 of 2 completed";
                        activities = new String[][] {
                                        { "Facilitated stress workshop", "3h ago" },
                                        { "Shared module \"Mindful Teaching\"", "1d ago" },
                                        { "Responded to 3 student queries", "2d ago" }
                        };
                        badges = new String[][] {
                                        { "Mindful Mentor", "blue" },
                                        { "Wellness Guide", "orange" },
                                        { "Campus Ally", "gold" }
                        };
                } else if ("professional".equals(role)) {
                        name = "Aisyah";
                        email = "aisyah@wellness.org";
                        roleTitle = "Mental Health Professional";
                        department = "Counseling Services";
                        score = 91;
                        improvementNote = "+1% improvement from last week";
                        modulesCompleted = 15;
                        dayStreak = 25;
                        goalDescription = "Respond to 5 virtual support requests";
                        goalCompleted = 4;
                        goalTarget = 5;
                        goalNote = "4 of 5 completed";
                        activities = new String[][] {
                                        { "Hosted calming strategies session", "1h ago" },
                                        { "Replied to support chat", "4h ago" },
                                        { "Updated coping module", "1d ago" }
                        };
                        badges = new String[][] {
                                        { "Guiding Light", "blue" },
                                        { "Support Champion", "orange" },
                                        { "Trusted Mentor", "gold" }
                        };

                        // Professional Specific Data
                        data.put("assignedStudents", new String[][] {
                                        { "1001", "Ahmad Ali", "High", "Critical", "Needs immediate follow-up" },
                                        { "1002", "Sarah Tan", "Moderate", "Monitoring", "Weekly check-ins" },
                                        { "1003", "Raj Kumar", "Low", "Stable", "Monthly maintenance" },
                                        { "1004", "Mei Ling", "High", "Active", "Stress management focus" },
                                        { "1005", "John Doe", "Moderate", "Active", "Anxiety support" }
                        });

                        data.put("appointments", new String[][] {
                                        { "09:00 AM", "Ahmad Ali", "Video Call", "Urgent" },
                                        { "11:30 AM", "Sarah Tan", "Chat", "Follow-up" },
                                        { "02:00 PM", "Mei Ling", "Video Call", "Therapy" },
                                        { "04:15 PM", "John Doe", "In-Person", "Assessment" }
                        });

                        data.put("resources", new String[][] {
                                        { "Coping with Exam Stress", "PDF", "1.2 MB", "120 Downloads" },
                                        { "Mindfulness Guide", "Video", "15 mins", "85 Views" },
                                        { "Sleep Hygiene 101", "Article", "5 mins", "45 Reads" }
                        });
                } else if ("admin".equals(role)) {
                        name = "Ain";
                        email = "ain@admin.edu";
                        roleTitle = "Administrator";
                        department = "System Administration";
                        score = 78;
                        improvementNote = "+3% improvement from last week";
                        modulesCompleted = 10;
                        dayStreak = 18;
                        goalDescription = "Review 4 escalated cases";
                        goalCompleted = 3;
                        goalTarget = 4;
                        goalNote = "3 of 4 completed";
                        activities = new String[][] {
                                        { "Approved community guideline update", "30m ago" },
                                        { "Enabled new learning paths", "5h ago" },
                                        { "Replied to faculty request", "1d ago" }
                        };
                        badges = new String[][] {
                                        { "Operations Pro", "blue" },
                                        { "Guardian", "orange" },
                                        { "Community Pillar", "gold" }
                        };
                }

                data.put("name", name);
                data.put("email", email);
                data.put("roleTitle", roleTitle);
                data.put("department", department);
                data.put("score", score);
                data.put("improvementNote", improvementNote);
                data.put("modulesCompleted", modulesCompleted);
                data.put("dayStreak", dayStreak);
                data.put("goalDescription", goalDescription);
                data.put("goalCompleted", goalCompleted);
                data.put("goalTarget", goalTarget);
                data.put("goalNote", goalNote);
                data.put("activities", activities);
                data.put("badges", badges);

                String avatarInitial = name.substring(0, 1).toUpperCase();
                int wellnessPercent = Math.min(100, Math.max(0, score));
                int goalPercent = (int) Math.round((goalCompleted * 100.0) / goalTarget);
                goalPercent = Math.min(100, Math.max(0, goalPercent));

                data.put("avatarInitial", avatarInitial);
                data.put("wellnessPercent", wellnessPercent);
                data.put("goalPercent", goalPercent);

                return data;
        }
}
