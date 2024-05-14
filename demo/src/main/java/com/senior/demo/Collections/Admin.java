package com.senior.demo.Collections;

import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

@Document(collection = "Admin")
public class Admin extends User {

    private String dob;
    @Field("deviceTokens")
    private List<String> deviceTokens;

    Admin(String id,String email, String password, Role role, String phone, String name, String dob,String imageId, List<String> deviceTokens) {
        super(id, email, password, role, phone, name,imageId);
        this.dob = dob;
        this.deviceTokens = deviceTokens;
    }

    public String getDob() {
        return dob;
    }
    public List<String> getDeviceTokens() {
        return deviceTokens;
    }

    public void setDeviceTokens(List<String> deviceTokens) {
        this.deviceTokens = deviceTokens;
    }

    public static class Builder {
        private String email;
        private String id;
        private String password;
        private Role role;
        private String phone;
        private String name;
        private String dob;
        private String imageId;
        private List<String> deviceTokens;

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder password(String password) {
            this.password = password;
            return this;
        }
        public Builder id(String id) {
            this.id = id;
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

        public Builder dob(String dob) {
            this.dob = dob;
            return this;
        }
        public Builder imageId(String imageId) {
            this.imageId = imageId;
            return this;
        }
        public Builder deviceToken(List<String> deviceTokens) {
            this.deviceTokens = deviceTokens;
            return this;
        }

        public Admin build() {
            return new Admin(id,email, password, role, phone, name, dob,imageId, deviceTokens);
        }
    }
}