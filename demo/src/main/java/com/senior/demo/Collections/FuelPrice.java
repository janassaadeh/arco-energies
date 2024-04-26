package com.senior.demo.Collections;

import com.senior.demo.Responses.FuelResponse;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDate;

@Entity
@Document(collection = "fuel_prices")
public class FuelPrice {

    @Id
    private String id;

    @Field("price")
    private double price;

    @Field("created_date")
    private LocalDate createdDate;

    //ManyToOne
    private FuelResponse fuel;

    public FuelPrice(String id, double price, LocalDate createdDate) {
        this.id = id;
        this.price = price;
        this.createdDate = createdDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public LocalDate getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    public FuelResponse getFuel() {
        return fuel;
    }

    public void setFuel(FuelResponse fuel) {
        this.fuel = fuel;
    }
}
