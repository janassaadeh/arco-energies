package com.senior.demo.Collections;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.ArrayList;
import java.util.List;

@Document(collection = "Operator")
@Data
public class Operator extends User {
    private String dob;
    private String address;
    private List<Transaction> transactions = new ArrayList<>();

    @Field("deviceTokens")
    private List<String> deviceTokens;

    public Operator(String id, String email, String password, Role role, String phone, String name, String dob, String address, String imageId, List<String> deviceTokens) {
        super(id, email, password, role, phone, name, imageId);
        this.dob = dob;
        this.address = address;
        this.deviceTokens = deviceTokens;
    }

    public void addTransaction(Transaction transaction) {
        transactions.add(transaction);
    }

    public void removeTransaction(Transaction transaction) {
        transactions.remove(transaction);
    }

    public String getDob() {
        return dob;
    }

    public String getAddress() {
        return address;
    }

    public List<String> getDeviceTokens() {
        return deviceTokens;
    }

    public void setDeviceTokens(List<String> deviceTokens) {
        this.deviceTokens = deviceTokens;
    }

    public static class Builders {
        private String id;
        private String email;
        private String password;
        private Role role;
        private String phone;
        private String name;
        private String dob;
        private String address;
        private String imageId;
        private List<String> deviceTokens;

        public Operator.Builders email(String email) {
            this.email = email;
            return this;
        }

        public Operator.Builders password(String password) {
            this.password = password;
            return this;
        }

        public Operator.Builders id(String id) {
            this.id = id;
            return this;
        }

        public Operator.Builders role(Role role) {
            this.role = role;
            return this;
        }

        public Operator.Builders phone(String phone) {
            this.phone = phone;
            return this;
        }

        public Operator.Builders name(String name) {
            this.name = name;
            return this;
        }

        public Operator.Builders dob(String dob) {
            this.dob = dob;
            return this;
        }

        public Operator.Builders address(String address) {
            this.address = address;
            return this;
        }

        public Operator.Builders imageId(String imageId) {
            this.imageId = imageId;
            return this;
        }

        public Operator.Builders deviceTokens(List<String> deviceTokens) {
            this.deviceTokens = deviceTokens;
            return this;
        }

        public Operator build() {
            return new Operator(id, email, password, role, phone, name, dob, address, imageId, deviceTokens);
        }
    }
}
