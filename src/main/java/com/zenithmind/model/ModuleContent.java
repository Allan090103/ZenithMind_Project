package com.zenithmind.model;

public class ModuleContent {
    private String slug;
    private String title;
    private String description;
    private String duration;
    private int points;
    private int progress;
    private String status;
    private String buttonLabel;
    private String icon;
    private String[] sections;
    private int currentSection;

    public ModuleContent(String slug, String title, String description, String duration,
            int points, int progress, String status, String buttonLabel,
            String icon, String[] sections, int currentSection) {
        this.slug = slug;
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.points = points;
        this.progress = progress;
        this.status = status;
        this.buttonLabel = buttonLabel;
        this.icon = icon;
        this.sections = sections;
        this.currentSection = Math.max(1, Math.min(currentSection, sections.length));
    }

    // Getters and Setters
    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getButtonLabel() {
        return buttonLabel;
    }

    public void setButtonLabel(String buttonLabel) {
        this.buttonLabel = buttonLabel;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String[] getSections() {
        return sections;
    }

    public void setSections(String[] sections) {
        this.sections = sections;
    }

    public int getCurrentSection() {
        return currentSection;
    }

    public void setCurrentSection(int currentSection) {
        this.currentSection = currentSection;
    }
}
