package com.zenithmind.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;

@Service
public class RegistrationService {

    @Autowired
    private DataSource dataSource;

    /**
     * Register a new student user
     * 
     * @param username Unique username
     * @param password Plain text password (will be encoded)
     * @param name     Full name of the student
     * @param email    Email address (optional)
     * @return true if registration successful, false if username already exists
     */
    public boolean registerStudent(String username, String password, String name, String email) {
        try {
            JdbcUserDetailsManager userDetailsManager = new JdbcUserDetailsManager(dataSource);

            // Check if username already exists
            if (userDetailsManager.userExists(username)) {
                return false;
            }

            // Create Spring Security user with ROLE_USER (for students)
            UserDetails newUser = User.withDefaultPasswordEncoder()
                    .username(username)
                    .password(password)
                    .roles("USER")
                    .build();

            // Create user in Spring Security tables (users and authorities)
            userDetailsManager.createUser(newUser);

            // Create user in app_users table for application-specific data
            createAppUser(username, name, email);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Create entry in app_users table
     */
    private void createAppUser(String username, String name, String email) {
        try {
            org.springframework.jdbc.core.JdbcTemplate jdbcTemplate = new org.springframework.jdbc.core.JdbcTemplate(
                    dataSource);

            // Insert into app_users table
            String sql = "INSERT INTO app_users (name, role, points) VALUES (?, ?, ?)";
            // Use username as the primary key 'name' to ensure matches with UserService
            // lookups
            jdbcTemplate.update(sql, username, "student", 0);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to create app user record", e);
        }
    }

    /**
     * Check if username is available
     */
    public boolean isUsernameAvailable(String username) {
        JdbcUserDetailsManager userDetailsManager = new JdbcUserDetailsManager(dataSource);
        return !userDetailsManager.userExists(username);
    }
}
