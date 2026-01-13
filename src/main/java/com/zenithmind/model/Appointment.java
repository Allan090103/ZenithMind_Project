package com.zenithmind.model;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

@Entity
@Table(name = "appointments")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "student_username", nullable = false)
    private String studentUsername;

    @Column(name = "counselor_username", nullable = false)
    private String counselorUsername;

    @Column(name = "appt_date", nullable = false)
    private Date apptDate;

    @Column(name = "appt_time", nullable = false)
    private String apptTime;

    @Column(name = "status")
    private String status;

    @Column(name = "type")
    private String type;

    @Column(name = "created_at", insertable = false, updatable = false)
    private Timestamp createdAt;

    // Constructors
    public Appointment() {
    }

    public Appointment(String studentUsername, String counselorUsername, Date apptDate, String apptTime, String status,
            String type) {
        this.studentUsername = studentUsername;
        this.counselorUsername = counselorUsername;
        this.apptDate = apptDate;
        this.apptTime = apptTime;
        this.status = status;
        this.type = type;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStudentUsername() {
        return studentUsername;
    }

    public void setStudentUsername(String studentUsername) {
        this.studentUsername = studentUsername;
    }

    public String getCounselorUsername() {
        return counselorUsername;
    }

    public void setCounselorUsername(String counselorUsername) {
        this.counselorUsername = counselorUsername;
    }

    public Date getApptDate() {
        return apptDate;
    }

    public void setApptDate(Date apptDate) {
        this.apptDate = apptDate;
    }

    public String getApptTime() {
        return apptTime;
    }

    public void setApptTime(String apptTime) {
        this.apptTime = apptTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
