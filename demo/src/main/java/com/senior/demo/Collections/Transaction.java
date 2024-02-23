package com.senior.demo.Collections;

import jakarta.persistence.Entity;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDate;

@Entity
@Document(collection = "transactions")
public class Transaction {

    @Id
    @Field("_id")
    private String id;

    @Field("quantity")
    private double quantity;

    @Field("odometer")
    private double odometer;

    @Field("date")
    private LocalDate date;

    public Transaction(String id, double quantity, double odometer, LocalDate date) {
        this.id = id;
        this.quantity = quantity;
        this.odometer = odometer;
        this.date = date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public double getOdometer() {
        return odometer;
    }

    public void setOdometer(double odometer) {
        this.odometer = odometer;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}

