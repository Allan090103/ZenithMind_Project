package com.zenithmind.model;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "assessment_results")
public class AssessmentResult {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(name = "assessment_type", nullable = false)
    private String assessmentType;

    @Column(nullable = false)
    private int score;

    @Column(name = "severity_level", nullable = false)
    private String severityLevel;

    @Column(name = "created_at")
    private Timestamp createdAt;

    public AssessmentResult() {
    }

    public AssessmentResult(String username, String assessmentType, int score, String severityLevel) {
        this.username = username;
        this.assessmentType = assessmentType;
        this.score = score;
        this.severityLevel = severityLevel;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAssessmentType() {
        return assessmentType;
    }

    public void setAssessmentType(String assessmentType) {
        this.assessmentType = assessmentType;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getSeverityLevel() {
        return severityLevel;
    }

    public void setSeverityLevel(String severityLevel) {
        this.severityLevel = severityLevel;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
