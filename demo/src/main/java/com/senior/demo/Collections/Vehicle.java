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
    @Field("_id")
    private String id;

    @Field("year")
    private int year;

    @Field("model")
    private String model;

    @Field("make")
    private String make;

    @Field("plate_number")
    private String plateNumber;

    @Field("driver_name")
    private String driverName;

    @Field("type")
    private String type;

    @OneToMany(mappedBy = "pump", cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.DETACH, CascadeType.REFRESH})
    private List<Transaction> transactions;

    public Vehicle(String id, int year, String model, String make, String plateNumber, String driverName, String type) {
        this.id = id;
        this.year = year;
        this.model = model;
        this.make = make;
        this.plateNumber = plateNumber;
        this.driverName = driverName;
        this.type = type;
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

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
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

    @Override
    public String toString() {
        return "Vehicle{" +
                "id='" + id + '\'' +
                ", year=" + year +
                ", model='" + model + '\'' +
                ", make='" + make + '\'' +
                ", plateNumber='" + plateNumber + '\'' +
                ", driverName='" + driverName + '\'' +
                ", type='" + type + '\'' +
                ", transactions=" + transactions +
                '}';
    }
}