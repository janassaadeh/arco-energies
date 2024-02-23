package com.senior.demo.Collections;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Operator")
@Data
public class Operator extends User {
    private String dob;
    private String address;

    public Operator(String id,String email, String password, Role role, String phone, String name, String dob, String address) {
        super(id,email, password, role, phone, name);
        this.dob = dob;
        this.address = address;
    }




    public String getDob() {
        return dob;
    }

    public String getAddress() {
        return address;
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
//private String id;
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

        public Operator build() {
            return new Operator(id,email, password, role, phone, name, dob, address);
        }
    }
}
