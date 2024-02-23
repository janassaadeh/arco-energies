package com.senior.demo.Collections;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Document(collection = "Company")
@Data
public class Company extends User {
    private double balance;
    private String contactName;
    private String location;
    private int pts;
    private Set<Reward> redeemedRewards = new HashSet<>();
    @DBRef
    private List<Reward> rewards = new ArrayList<>();

    // Constructor, getters, setters...


    public boolean hasRedeemedReward(String rewardId) {
        return redeemedRewards.contains(rewardId);
    }

    // Method to add a redeemed reward
//    public void addRedeemedReward(String rewardId) {
//        redeemedRewards.add(rewardId);
//    }
    // Constructor with ID parameter
    public Company(String id, String email, String password, Role role, String phone, String name, double balance, String contactName, String location,int pts, Set<Reward> redeemedRewards) {
        super(id,email, password, role, phone, name);
        this.balance = balance;
        this.contactName = contactName;
        this.location = location;
        this.pts = pts;
        this.redeemedRewards=redeemedRewards;

    }

    public double getBalance() {
        return balance;
    }

    public String getContactName() {
        return contactName;
    }

    public String getLocation() {
        return location;
    }

    // Builder class
    public static class Builder {
        private String id;
        private String email;
        private String password;
        private Role role;
        private String phone;
        private String name;
        private double balance;
        private String contactName;
        private String location;
        private  int pts;
        private Set<Reward> redeemedRewards;

        public Builder id(String id) {
            this.id = id;
            return this;
        }

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder password(String password) {
            this.password = password;
            return this;
        }

        public Builder role(Role role) {
            this.role = role;
            return this;
        }

        public Builder phone(String phone) {
            this.phone = phone;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder balance(double balance) {
            this.balance = balance;
            return this;
        }

        public Builder contactName(String contactName) {
            this.contactName = contactName;
            return this;
        }
        public Builder redeemedRewards(Set<Reward> redeemedRewards) {
            this.redeemedRewards = redeemedRewards;
            return this;
        }

        public Builder location(String location) {
            this.location = location;
            return this;
        }
        public Builder pts(int pts) {
            this.pts = pts;
            return this;
        }

        // Build method to create Company object
        public Company build() {
            return new Company(id, email, password, role, phone, name, balance, contactName, location,pts,redeemedRewards);
        }
    }
}
