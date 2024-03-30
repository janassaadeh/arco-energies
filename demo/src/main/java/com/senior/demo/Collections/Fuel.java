package com.senior.demo.Collections;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.ArrayList;
import java.util.List;

@Entity
@Document(collection = "fuels")
public class Fuel {

    @Id
    private String id;
    private String type;
    private String description;

    //OneToMany
    private List<FuelPrice> prices;

    //OneToMany
    private List<Pump> pumps;

    public List<Pump> getPumps() {
        return pumps;
    }
    public void setPumps(List<Pump> pumps) {
        this.pumps = pumps;
    }

    public List<FuelPrice> getPrices() {
        return prices;
    }

    public void setPrices(List<FuelPrice> prices) {
        this.prices = prices;
    }

    public Fuel(String id, String type, String description) {
        this.id = id;
        this.type = type;
        this.description = description;
        this.prices = new ArrayList<>();
        this.pumps = new ArrayList<>();
    }

    public void updateTypeAndDescription(String type, String description) {
        this.type = type;
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}