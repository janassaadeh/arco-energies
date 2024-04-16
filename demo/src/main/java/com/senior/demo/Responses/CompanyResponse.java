package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;
@AllArgsConstructor

@Data
public class CompanyResponse {
    String id;
    String email;  String phone; String name; double balance;
    String contactName; String location;

    Integer pts;
//    Boolean activated;



}
