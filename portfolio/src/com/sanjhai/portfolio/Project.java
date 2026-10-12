package com.sanjhai.portfolio;

/**
 * Simple data holder for one portfolio project.
 * Populated by {@link ProjectService} and rendered by projects.jsp.
 */
public class Project {

    private final String title;
    private final String category;      // used by the client-side filter buttons
    private final String status;        // display label, e.g. "Selected"
    private final String statusClass;   // css class: selected | review | published
    private final String description;
    private final String[] tech;

    public Project(String title, String category, String status, String statusClass,
                    String description, String[] tech) {
        this.title = title;
        this.category = category;
        this.status = status;
        this.statusClass = statusClass;
        this.description = description;
        this.tech = tech;
    }

    public String getTitle() { return title; }
    public String getCategory() { return category; }
    public String getStatus() { return status; }
    public String getStatusClass() { return statusClass; }
    public String getDescription() { return description; }
    public String[] getTech() { return tech; }
}
