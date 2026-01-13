package com.zenithmind.model;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

@Entity
@Table(name = "mood_logs")
public class MoodLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String mood;

    @Column(name = "mood_score", nullable = false)
    private int moodScore;

    private String activities;

    @Column(columnDefinition = "TEXT")
    private String note;

    @Column(name = "log_date", nullable = false)
    private Date logDate;

    @Column(name = "created_at")
    private Timestamp createdAt;

    public MoodLog() {
    }

    public MoodLog(String username, String mood, int moodScore, String activities, String note, Date logDate) {
        this.username = username;
        this.mood = mood;
        this.moodScore = moodScore;
        this.activities = activities;
        this.note = note;
        this.logDate = logDate;
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

    public String getMood() {
        return mood;
    }

    public void setMood(String mood) {
        this.mood = mood;
    }

    public int getMoodScore() {
        return moodScore;
    }

    public void setMoodScore(int moodScore) {
        this.moodScore = moodScore;
    }

    public String getActivities() {
        return activities;
    }

    public void setActivities(String activities) {
        this.activities = activities;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
