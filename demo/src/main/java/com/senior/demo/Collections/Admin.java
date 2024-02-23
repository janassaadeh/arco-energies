package com.senior.demo.Collections;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Admin")
public class Admin extends User {

    private String dob;

    Admin(String id,String email, String password, Role role, String phone, String name, String dob) {
        super(id, email, password, role, phone, name);
        this.dob = dob;
    }

    public String getDob() {
        return dob;
    }

    public static class Builder {
        private String email;
        private String id;
        private String password;
        private Role role;
        private String phone;
        private String name;
        private String dob;

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

        public Admin build() {
            return new Admin(id,email, password, role, phone, name, dob);
        }
    }
}