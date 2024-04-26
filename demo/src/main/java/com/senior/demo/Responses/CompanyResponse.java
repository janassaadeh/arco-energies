package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;
//@AllArgsConstructor

@Data
public class CompanyResponse {
    String id;
    String email;  String phone; String name; double balance;
    String contactName; String location;

    Integer pts;
//    Boolean activated;

    public CompanyResponse(String id, String email, String phone, String name, double balance, String contactName, String location, Integer pts, String imageId) {
        this.id = id;
        this.email = email;
        this.phone = phone;
        this.name = name;
        this.balance = balance;
        this.contactName = contactName;
        this.location = location;
        this.pts = pts;
        this.imageId = imageId;
    }

    String imageId;

}
