package com.senior.demo.Collections;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Company")
@Data
public class Company extends User {
    private double balance;
    private String contactName;
    private String location;

    // Constructor with ID parameter
    public Company(String id, String email, String password, Role role, String phone, String name, double balance, String contactName, String location) {
        super(id,email, password, role, phone, name);
        this.balance = balance;
        this.contactName = contactName;
        this.location = location;
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

        public Builder location(String location) {
            this.location = location;
            return this;
        }

        // Build method to create Company object
        public Company build() {
            return new Company(id, email, password, role, phone, name, balance, contactName, location);
        }
    }
}
