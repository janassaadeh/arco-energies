package com.senior.demo.Collections;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

@Document(collection = "Reward")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reward {
    @Id
    private String id;

    private String name;
    private Instant redemptionTime; // New field to track redemption time

    public Reward(String name, int pts, String description, String category) {
        this.name = name;
        this.pts = pts;
        this.description = description;
        this.category = category;
    }

    private int pts;
    private String description;
    private String category;

    public Instant getRedemptionTime() {
        return redemptionTime;
    }

    public void setRedemptionTime(Instant redemptionTime) {
        this.redemptionTime = redemptionTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
