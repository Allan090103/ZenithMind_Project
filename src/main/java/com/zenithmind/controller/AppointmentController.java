package com.zenithmind.controller;

import com.zenithmind.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller; // Changed from RestController to Controller to handle both if needed, but for API better RestController
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Map;

@RestController
@RequestMapping("/api/appointments")
public class AppointmentController {

    @Autowired
    private UserService userService;

    @PostMapping("/book")
    public ResponseEntity<?> bookAppointment(@RequestParam String counselor,
            @RequestParam String date,
            @RequestParam String time,
            Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        String studentUsername = principal.getName();
        // Map friendly counselor name to username if needed, or frontend sends
        // username.
        // Frontend sends 'Dr. Sarah Johnson' etc in existing JS. We need to map or
        // change frontend to send username/email.
        // For 'Aisyah', username is 'aisyah@wellness.org'.
        // Let's assume frontend will be updated to send the correct username/email.

        boolean success = userService.bookAppointment(studentUsername, counselor, date, time);
        if (success) {
            return ResponseEntity.ok().body(Map.of("message", "Appointment booked successfully"));
        } else {
            return ResponseEntity.badRequest().body(Map.of("message", "Failed to book appointment"));
        }
    }
}
