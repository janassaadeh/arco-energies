package com.senior.demo.Collections;

import jakarta.persistence.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.ArrayList;
import java.util.List;

@Entity
@Document(collection = "vehicles")
public class Vehicle {

    @Id
    private String id;

    @Field("year")
    private int year;

    @Field("model")
    private String model;

    @Field("plate_number")
    private String plateNumber;

    @Field("driver_name")
    private String driverName;

    @Field("type")
    private String type;

    @Field("color")
    private String color;

    // OneToMany
    private List<Transaction> transactions;

    public Vehicle(String id, int year, String model, String plateNumber, String driverName, String type, String color) {
        this.id = id;
        this.year = year;
        this.model = model;
        this.plateNumber = plateNumber;
        this.driverName = driverName;
        this.type = type;
        this.color = color;
        this.transactions = new ArrayList<>();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }


    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id='" + id + '\'' +
                ", year=" + year +
                ", model='" + model + '\'' +
                ", plateNumber='" + plateNumber + '\'' +
                ", driverName='" + driverName + '\'' +
                ", type='" + type + '\'' +
                ", color='" + color + '\'' +
                ", transactions=" + transactions +
                '}';
    }
}