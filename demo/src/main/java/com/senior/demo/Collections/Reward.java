package com.senior.demo.Collections;

public class Reward {
    private String name;

    private int pts;
    private String description;

    public Reward(int pts, String description) {
        this.pts = pts;
        this.description = description;
    }

    // Getters and Setters
    public int getPts() {
        return pts;
    }

    public void setPts(int pts) {
        this.pts = pts;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // toString method to represent Reward object as String
    @Override
    public String toString() {
        return "Reward{" +
                "pts=" + pts +
                ", description='" + description + '\'' +
                '}';
    }
}
