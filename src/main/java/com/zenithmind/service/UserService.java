package com.zenithmind.service;

import com.zenithmind.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {

        @javax.annotation.PostConstruct
        public void init() {
                JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                try {
                        jdbcTemplate.execute("ALTER TABLE app_users ADD COLUMN wellness_score INT DEFAULT 50");
                        System.out.println("Migrated DB: Added wellness_score column.");
                } catch (Exception e) {
                        System.out.println("DB Migration check: " + e.getMessage());
                }
                try {
                        jdbcTemplate.update(
                                        "UPDATE app_users SET wellness_score = 50 WHERE wellness_score = 0 OR wellness_score IS NULL");
                        System.out.println("Migrated DB: Fixed 0 or NULL wellness_score values.");
                } catch (Exception e) {
                        System.out.println("DB Data fix check: " + e.getMessage());
                }

                // Ensure mood_logs table exists
                try {
                        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS mood_logs (" +
                                        "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                                        "username VARCHAR(50) NOT NULL," +
                                        "mood VARCHAR(50) NOT NULL," +
                                        "mood_score INT NOT NULL," +
                                        "activities VARCHAR(255)," +
                                        "note TEXT," +
                                        "log_date DATE NOT NULL," +
                                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                                        ")");
                        System.out.println("Migrated DB: Ensured mood_logs table exists.");
                } catch (Exception e) {
                        System.out.println("DB mood_logs check: " + e.getMessage());
                }

                // Ensure assessment_results table exists
                try {
                        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS assessment_results (" +
                                        "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                                        "username VARCHAR(50) NOT NULL," +
                                        "assessment_type VARCHAR(255) NOT NULL," +
                                        "score INT NOT NULL," +
                                        "severity_level VARCHAR(255) NOT NULL," +
                                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                                        ")");
                        System.out.println("Migrated DB: Ensured assessment_results table exists.");
                } catch (Exception e) {
                        System.out.println("DB assessment_results check: " + e.getMessage());
                }

                // Ensure user_module_progress table exists
                try {
                        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS user_module_progress (" +
                                        "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                                        "username VARCHAR(50) NOT NULL," +
                                        "module_slug VARCHAR(100) NOT NULL," +
                                        "current_section INT DEFAULT 1," +
                                        "status VARCHAR(20) DEFAULT 'start'," +
                                        "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                                        "UNIQUE KEY unique_user_module (username, module_slug)" +
                                        ")");
                        System.out.println("Migrated DB: Ensured user_module_progress table exists.");
                } catch (Exception e) {
                        System.out.println("DB user_module_progress check: " + e.getMessage());
                }

                // Ensure appointments table exists
                try {
                        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS appointments (" +
                                        "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                                        "student_username VARCHAR(50) NOT NULL," +
                                        "counselor_username VARCHAR(50) NOT NULL," +
                                        "appt_date DATE NOT NULL," +
                                        "appt_time VARCHAR(50) NOT NULL," +
                                        "status VARCHAR(20) DEFAULT 'Pending'," +
                                        "type VARCHAR(50) DEFAULT 'Video Call'," +
                                        "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                                        "CONSTRAINT fk_appt_student FOREIGN KEY (student_username) REFERENCES users(username),"
                                        +
                                        "CONSTRAINT fk_appt_counselor FOREIGN KEY (counselor_username) REFERENCES users(username)"
                                        +
                                        ")");
                        System.out.println("Migrated DB: Ensured appointments table exists.");
                } catch (Exception e) {
                        System.out.println("DB appointments check: " + e.getMessage());
                }

                // Ensure faculty_training_progress table exists
                try {
                        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS faculty_training_progress (" +
                                        "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                                        "username VARCHAR(50) NOT NULL," +
                                        "module_slug VARCHAR(255) NOT NULL," +
                                        "current_section INT DEFAULT 1," +
                                        "status VARCHAR(20) DEFAULT 'start'," +
                                        "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                                        "UNIQUE KEY uk_faculty_module (username, module_slug)" +
                                        ")");
                        System.out.println("Migrated DB: Ensured faculty_training_progress table exists.");
                } catch (Exception e) {
                        System.out.println("DB faculty_training_progress check: " + e.getMessage());
                }
        }

        @Autowired
        private DataSource dataSource;

        /**
         * Get user data by username from database
         */
        public Map<String, Object> getUserDataByUsername(String username, String role) {
                if (role == null)
                        role = "student";
                role = role.toLowerCase();

                Map<String, Object> data = new HashMap<>();

                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

                        // Query app_users table for user's actual data
                        String sql = "SELECT name, role, points, wellness_score FROM app_users WHERE name = ? LIMIT 1";

                        try {
                                Map<String, Object> userRow = jdbcTemplate.queryForMap(sql, username);

                                // Use actual user data from database
                                String name = (String) userRow.get("name");
                                int points = userRow.get("points") != null ? ((Number) userRow.get("points")).intValue()
                                                : 0;
                                int wellnessScore = userRow.get("wellness_score") != null
                                                ? ((Number) userRow.get("wellness_score")).intValue()
                                                : 50;

                                System.out.println(
                                                "DEBUG: User " + username + " wellnessScore from DB: " + wellnessScore);

                                data.put("name", name);
                                data.put("email", username.toLowerCase().replace(" ", "") + "@student.edu");
                                data.put("roleTitle", "Student");
                                data.put("department", "Computer Science Department");
                                data.put("score", points);
                                data.put("wellnessScore", wellnessScore);
                                data.put("improvementNote", "Welcome! Start your wellness journey");
                                // Fetch actual completed modules count
                                int completedModules = getCompletedModulesCount(username);
                                data.put("modulesCompleted", completedModules);
                                data.put("dayStreak", 0);
                                data.put("goalDescription", "Complete 3 modules this week");
                                data.put("goalCompleted", 0);
                                data.put("goalTarget", 3);
                                data.put("goalNote", "0 of 3 completed");
                                data.put("activities", new String[][] {
                                                { "Joined ZenithMind", "Just now" }
                                });
                                data.put("badges", new String[][] {
                                                { "First Steps", "blue" }
                                });

                        } catch (Exception e) {
                                System.err.println("Database lookup failed for " + username + ": " + e.getMessage());
                                e.printStackTrace();
                                // User not found in database, use username as fallback
                                data.put("name", username);
                                data.put("email", username.toLowerCase() + "@student.edu");
                                data.put("roleTitle", "Student");
                                data.put("department", "Computer Science Department");
                                data.put("score", 0);
                                data.put("improvementNote", "Welcome! Start your wellness journey");
                                // Fetch actual completed modules count
                                int completedModules = getCompletedModulesCount(username);
                                data.put("modulesCompleted", completedModules);
                                data.put("dayStreak", 0);
                                data.put("goalDescription", "Complete 3 modules this week");
                                data.put("goalCompleted", 0);
                                data.put("goalTarget", 3);
                                data.put("goalNote", "0 of 3 completed");
                                data.put("activities", new String[][] {
                                                { "Joined ZenithMind", "Just now" }
                                });
                                data.put("badges", new String[][] {
                                                { "First Steps", "blue" }
                                });
                        }

                } catch (Exception e) {
                        e.printStackTrace();
                        System.err.println("Error fetching user data for " + username + ": " + e.getMessage());
                        // Return default data on error
                        return getUserData(role);
                }

                // Add common calculated fields
                String avatarInitial = ((String) data.get("name")).substring(0, 1).toUpperCase();
                // Use persisted wellness score
                int wellnessPercent = data.containsKey("wellnessScore") ? (int) data.get("wellnessScore")
                                : Math.min(100, Math.max(0, (int) data.get("score")));
                int goalCompleted = (int) data.get("goalCompleted");
                int goalTarget = (int) data.get("goalTarget");
                int goalPercent = (int) Math.round((goalCompleted * 100.0) / goalTarget);
                goalPercent = Math.min(100, Math.max(0, goalPercent));

                data.put("avatarInitial", avatarInitial);
                data.put("wellnessPercent", wellnessPercent);
                data.put("goalPercent", goalPercent);

                return data;
        }

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

        /**
         * Update user points by adding the specified amount
         * 
         * @param username    The username to update
         * @param pointsToAdd The number of points to add
         * @return true if update was successful, false otherwise
         */
        public boolean updateUserPoints(String username, int pointsToAdd) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "UPDATE app_users SET points = points + ? WHERE name = ?";
                        int rowsAffected = jdbcTemplate.update(sql, pointsToAdd, username);
                        return rowsAffected > 0;
                } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                }
        }

        /**
         * Get current points for a user
         * 
         * @param username The username to query
         * @return Current points, or 0 if user not found
         */
        public int getUserPoints(String username) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT points FROM app_users WHERE name = ? LIMIT 1";
                        Integer points = jdbcTemplate.queryForObject(sql, Integer.class, username);
                        return points != null ? points : 0;
                } catch (Exception e) {
                        return 0;
                }
        }

        /**
         * Save a mood log entry to the database
         */
        public boolean saveMoodLog(String username, String mood, int moodScore, String activities, String note) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "INSERT INTO mood_logs (username, mood, mood_score, activities, note, log_date) VALUES (?, ?, ?, ?, ?, CURDATE())";
                        int rowsAffected = jdbcTemplate.update(sql, username, mood, moodScore, activities, note);

                        if (rowsAffected > 0) {
                                calculateAndSaveWellnessScore(username);
                                return true;
                        }
                        return false;
                } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                }
        }

        /**
         * Get recent mood logs for a user
         */
        public java.util.List<Map<String, Object>> getMoodLogsByUsername(String username, int limit) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT id, mood, mood_score, activities, note, log_date, created_at FROM mood_logs WHERE username = ? ORDER BY created_at DESC LIMIT ?";
                        return jdbcTemplate.queryForList(sql, username, limit);
                } catch (Exception e) {
                        e.printStackTrace();
                        return new java.util.ArrayList<>();
                }
        }

        /**
         * Get mood statistics for a user
         */
        public Map<String, Object> getMoodStats(String username) {
                Map<String, Object> stats = new HashMap<>();
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

                        // Total logs
                        String countSql = "SELECT COUNT(*) FROM mood_logs WHERE username = ?";
                        Integer totalLogs = jdbcTemplate.queryForObject(countSql, Integer.class, username);
                        stats.put("totalLogs", totalLogs != null ? totalLogs : 0);

                        // Average mood score
                        String avgSql = "SELECT AVG(mood_score) FROM mood_logs WHERE username = ?";
                        Double avgMood = jdbcTemplate.queryForObject(avgSql, Double.class, username);
                        stats.put("averageMood", avgMood != null ? Math.round(avgMood * 10.0) / 10.0 : 0.0);

                        // Day streak (consecutive days with logs)
                        String streakSql = "SELECT COUNT(DISTINCT log_date) FROM mood_logs WHERE username = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
                        Integer streak = jdbcTemplate.queryForObject(streakSql, Integer.class, username);
                        stats.put("dayStreak", streak != null ? streak : 0);

                } catch (Exception e) {
                        e.printStackTrace();
                        stats.put("totalLogs", 0);
                        stats.put("averageMood", 0.0);
                        stats.put("dayStreak", 0);
                }
                return stats;
        }

        /**
         * Save an assessment result to the database
         */
        public boolean saveAssessmentResult(String username, String assessmentType, int score, String severityLevel) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "INSERT INTO assessment_results (username, assessment_type, score, severity_level) VALUES (?, ?, ?, ?)";
                        int rowsAffected = jdbcTemplate.update(sql, username, assessmentType, score, severityLevel);

                        if (rowsAffected > 0) {
                                calculateAndSaveWellnessScore(username);
                                return true;
                        }
                        return false;
                } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                }
        }

        /**
         * Calculate and update wellness score based on mood and assessment
         */
        public void calculateAndSaveWellnessScore(String username) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

                        // 1. Get Average Mood Score (Last 7 Days)
                        // Normalize 1-5 to 0-100
                        String moodSql = "SELECT AVG(mood_score) FROM mood_logs WHERE username = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
                        Double avgMood = jdbcTemplate.queryForObject(moodSql, Double.class, username);

                        Integer moodComponent = null;
                        if (avgMood != null) {
                                moodComponent = (int) Math.round((avgMood / 5.0) * 100);
                        }

                        // 2. Get Latest Assessment Result
                        // Score comes as 0-100 (Symptom Severity). We want Wellness, so 100 - Severity.
                        String assessmentSql = "SELECT score FROM assessment_results WHERE username = ? ORDER BY created_at DESC LIMIT 1";
                        Integer assessmentSeverity = null;
                        try {
                                assessmentSeverity = jdbcTemplate.queryForObject(assessmentSql, Integer.class,
                                                username);
                        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
                                // No assessment found
                        }

                        Integer assessmentComponent = null;
                        if (assessmentSeverity != null) {
                                assessmentComponent = 100 - assessmentSeverity;
                        }

                        // 3. Calculate Weighted Average
                        int newScore = 50; // Default

                        if (moodComponent != null && assessmentComponent != null) {
                                newScore = (moodComponent + assessmentComponent) / 2;
                        } else if (moodComponent != null) {
                                newScore = moodComponent;
                        } else if (assessmentComponent != null) {
                                newScore = assessmentComponent;
                        }

                        // Clamp 0-100
                        newScore = Math.min(100, Math.max(0, newScore));

                        // 4. Update Database
                        String updateSql = "UPDATE app_users SET wellness_score = ? WHERE name = ?";
                        jdbcTemplate.update(updateSql, newScore, username);

                } catch (Exception e) {
                        e.printStackTrace();
                }
        }

        /**
         * Get assessment results for a user
         */
        public java.util.List<Map<String, Object>> getAssessmentResultsByUsername(String username) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT id, assessment_type, score, severity_level, created_at FROM assessment_results WHERE username = ? ORDER BY created_at DESC";
                        return jdbcTemplate.queryForList(sql, username);
                } catch (Exception e) {
                        e.printStackTrace();
                        return new java.util.ArrayList<>();
                }
        }

        /**
         * Get current wellness score for a user
         */
        public int getWellnessScore(String username) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT wellness_score FROM app_users WHERE name = ? LIMIT 1";
                        Integer score = jdbcTemplate.queryForObject(sql, Integer.class, username);
                        return score != null ? score : 50;
                } catch (Exception e) {
                        return 50;
                }
        }

        /**
         * Save or update module progress
         */
        public void saveModuleProgress(String username, String moduleSlug, int currentSection, String status) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "INSERT INTO user_module_progress (username, module_slug, current_section, status) "
                                        +
                                        "VALUES (?, ?, ?, ?) " +
                                        "ON DUPLICATE KEY UPDATE current_section = ?, status = ?";
                        jdbcTemplate.update(sql, username, moduleSlug, currentSection, status, currentSection, status);
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }

        /**
         * Get progress for a specific module
         */
        public Map<String, Object> getModuleProgress(String username, String moduleSlug) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT current_section, status FROM user_module_progress WHERE username = ? AND module_slug = ?";
                        return jdbcTemplate.queryForMap(sql, username, moduleSlug);
                } catch (Exception e) {
                        return null; // No progress found
                }
        }

        /**
         * Get all module progress for a user
         */
        public Map<String, Map<String, Object>> getAllModuleProgress(String username) {
                Map<String, Map<String, Object>> progressMap = new HashMap<>();
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT module_slug, current_section, status FROM user_module_progress WHERE username = ?";
                        java.util.List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, username);

                        for (Map<String, Object> row : rows) {
                                String slug = (String) row.get("module_slug");
                                progressMap.put(slug, row);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return progressMap;
        }

        /**
         * Save or update faculty training progress
         */
        public void saveFacultyTrainingProgress(String username, String moduleSlug, int currentSection, String status) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "INSERT INTO faculty_training_progress (username, module_slug, current_section, status) "
                                        +
                                        "VALUES (?, ?, ?, ?) " +
                                        "ON DUPLICATE KEY UPDATE current_section = ?, status = ?";
                        jdbcTemplate.update(sql, username, moduleSlug, currentSection, status, currentSection, status);
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }

        /**
         * Get all faculty training progress for a user
         */
        public Map<String, Map<String, Object>> getFacultyTrainingProgress(String username) {
                Map<String, Map<String, Object>> progressMap = new HashMap<>();
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT module_slug, current_section, status FROM faculty_training_progress WHERE username = ?";
                        java.util.List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, username);

                        for (Map<String, Object> row : rows) {
                                String slug = (String) row.get("module_slug");
                                progressMap.put(slug, row);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return progressMap;
        }

        /**
         * Get count of completed modules
         */
        public int getCompletedModulesCount(String username) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT COUNT(*) FROM user_module_progress WHERE username = ? AND status = 'done'";
                        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
                        return count != null ? count : 0;
                } catch (Exception e) {
                        return 0;
                }
        }

        public boolean bookAppointment(String studentUsername, String counselorUsername, String date, String time) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "INSERT INTO appointments (student_username, counselor_username, appt_date, appt_time) VALUES (?, ?, ?, ?)";
                        int rowsAffected = jdbcTemplate.update(sql, studentUsername, counselorUsername, date, time);
                        return rowsAffected > 0;
                } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                }
        }

        /**
         * Get appointments for a counselor
         */

        /**
         * Get appointments for a counselor
         */
        public java.util.List<Map<String, Object>> getAppointmentsForCounselor(String counselorUsername) {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        // Join with app_users to get student name
                        String sql = "SELECT a.id, a.appt_time, u.name as student_name, a.type, a.status, a.appt_date "
                                        +
                                        "FROM appointments a " +
                                        "LEFT JOIN app_users u ON a.student_username = u.name " + // Changed to LEFT
                                                                                                  // JOIN for debugging
                                        "WHERE a.counselor_username = ? AND a.appt_date >= CURDATE() " +
                                        "ORDER BY a.appt_date ASC, a.appt_time ASC";
                        System.out.println("DEBUG: UserService - Fetching appointments for: " + counselorUsername);
                        java.util.List<Map<String, Object>> results = jdbcTemplate.queryForList(sql, counselorUsername);
                        System.out.println("DEBUG: UserService - Query returned " + results.size() + " rows");
                        for (Map<String, Object> row : results) {
                                System.out.println("DEBUG: Row: " + row);
                        }
                        return results;
                } catch (Exception e) {
                        e.printStackTrace();
                        return new java.util.ArrayList<>();
                }
        }

        /**
         * Get all users from the database with derived fields
         */
        public java.util.List<Map<String, Object>> getAllUsers() {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT name, role FROM app_users";
                        java.util.List<Map<String, Object>> users = jdbcTemplate.queryForList(sql);

                        for (Map<String, Object> user : users) {
                                String name = (String) user.get("name");
                                String role = (String) user.get("role");
                                if (role == null)
                                        role = "student";

                                // Generate email
                                String emailDomain = "student.edu";
                                if ("admin".equalsIgnoreCase(role))
                                        emailDomain = "admin.edu";
                                else if ("faculty".equalsIgnoreCase(role))
                                        emailDomain = "faculty.edu";
                                else if ("professional".equalsIgnoreCase(role) || "counselor".equalsIgnoreCase(role))
                                        emailDomain = "wellness.org";

                                String email = name.toLowerCase().replace(" ", "") + "@" + emailDomain;
                                user.put("email", email);

                                // Generate department
                                String department = "Computer Science";
                                if ("admin".equalsIgnoreCase(role))
                                        department = "System Administration";
                                else if ("faculty".equalsIgnoreCase(role))
                                        department = "Psychology";
                                else if ("professional".equalsIgnoreCase(role) || "counselor".equalsIgnoreCase(role))
                                        department = "Counseling Services";
                                else if ("student".equalsIgnoreCase(role)) {
                                        // Randomize department for variety if needed, or stick to default
                                        department = "Computer Science";
                                }
                                user.put("department", department);

                                // Status (assume active for now)
                                user.put("status", "Active");
                        }
                        return users;
                } catch (Exception e) {
                        e.printStackTrace();
                        return new java.util.ArrayList<>();
                }
        }

        /**
         * Get total user count
         */
        public int getTotalUserCount() {
                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        // Exclude admin from the total count
                        String sql = "SELECT COUNT(*) FROM app_users WHERE LOWER(role) != 'admin'";
                        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
                        return count != null ? count : 0;
                } catch (Exception e) {
                        e.printStackTrace();
                        return 0;
                }
        }

        /**
         * Get counts for each user role
         */
        public java.util.Map<String, Integer> getUserRoleCounts() {
                java.util.Map<String, Integer> roleCounts = new java.util.HashMap<>();
                roleCounts.put("student", 0);
                roleCounts.put("faculty", 0);
                roleCounts.put("professional", 0);

                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
                        String sql = "SELECT role, COUNT(*) as count FROM app_users WHERE LOWER(role) != 'admin' GROUP BY role";

                        java.util.List<java.util.Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

                        for (java.util.Map<String, Object> row : rows) {
                                String role = (String) row.get("role");
                                Number count = (Number) row.get("count");
                                if (role != null && count != null) {
                                        String roleKey = role.toLowerCase();
                                        if ("counselor".equals(roleKey)) {
                                                roleKey = "professional";
                                        }
                                        roleCounts.put(roleKey, roleCounts.getOrDefault(roleKey, 0) + count.intValue());
                                }
                        }
                        return roleCounts;
                } catch (Exception e) {
                        e.printStackTrace();
                        return roleCounts;
                }
        }

        /**
         * Get platform analytics stats
         */
        public java.util.Map<String, Integer> getPlatformAnalytics() {
                java.util.Map<String, Integer> stats = new java.util.HashMap<>();
                stats.put("modulesCompleted", 0);
                stats.put("forumPosts", 0);
                stats.put("supportSessions", 0);

                try {
                        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

                        // Modules Completed
                        try {
                                String sqlModules = "SELECT COUNT(*) FROM user_module_progress WHERE status = 'done'";
                                Integer modules = jdbcTemplate.queryForObject(sqlModules, Integer.class);
                                stats.put("modulesCompleted", modules != null ? modules : 0);
                        } catch (Exception e) {
                                // Table might not exist yet, defaulting to 0
                                System.out.println("Error fetching modules count: " + e.getMessage());
                        }

                        // Forum Posts
                        String sqlPosts = "SELECT COUNT(*) FROM posts";
                        Integer posts = jdbcTemplate.queryForObject(sqlPosts, Integer.class);
                        stats.put("forumPosts", posts != null ? posts : 0);

                        // Support Sessions
                        String sqlSessions = "SELECT COUNT(*) FROM appointments";
                        Integer sessions = jdbcTemplate.queryForObject(sqlSessions, Integer.class);
                        stats.put("supportSessions", sessions != null ? sessions : 0);

                        return stats;
                } catch (Exception e) {
                        e.printStackTrace();
                        return stats;
                }
        }
}
