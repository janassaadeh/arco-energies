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
    @Field("_id")
    private String id;

    @Field("name")
    private String name;
    @Field("status")
    private String status;

    @ManyToOne(cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.DETACH, CascadeType.REFRESH})
    @JoinColumn(name = "fuel_id", referencedColumnName = "id")
    private Fuel fuel;

    @OneToMany(mappedBy = "pump", cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.DETACH, CascadeType.REFRESH})
    private List<Transaction> transactions;

    public Fuel getFuel() {
        return fuel;
    }

    public void setFuel(Fuel fuel) {
        this.fuel = fuel;
    }

    public Pump(String id, String name, String status) {
        this.id = id;
        this.name = name;
        this.status = status;
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

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }

    @Override
    public String toString() {
        return "Pump{" +
                " id = "+ id+
                ", name='" + name + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}