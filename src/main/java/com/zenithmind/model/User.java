package com.zenithmind.model;

public class User {
    private String name;
    private String role;
    private int points;

    public User(String name, String role, int points) {
        this.name = name;
        this.role = role;
        this.points = points;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }
}
