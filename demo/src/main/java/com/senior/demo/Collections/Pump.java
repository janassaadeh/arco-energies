package com.senior.demo.Collections;

import jakarta.persistence.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.ArrayList;
import java.util.List;

@Entity
@Document(collection = "pumps")
public class Pump {

    @Id
    private String id;

    @Field("name")
    private String name;

    @Field("petrol_type")
    private String petrolType;

    @Field("currency")
    private String currency;
    @Field("status")
    private String status;

    // ManyToOne
    private Fuel fuel;

    // OneToMany
    private List<Transaction> transactions;

    public Fuel getFuel() {
        return fuel;
    }

    public void setFuel(Fuel fuel) {
        this.fuel = fuel;
    }

    public Pump(String id, String name, String status, String petrolType, String currency) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.petrolType = petrolType;
        this.currency = currency;
        this.transactions = new ArrayList<>();
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public String getPetrolType() {
        return petrolType;
    }

    public void setPetrolType(String petrolType) {
        this.petrolType = petrolType;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }


    @Override
    public String toString() {
        return "Pump{" +
                " id = "+ id+
                ", name='" + name + '\'' +
                ", status='" + status + '\'' +
                ", petrol_type='" + petrolType + '\'' +
                ", currency='" + currency + '\'' +
                '}';
    }
}