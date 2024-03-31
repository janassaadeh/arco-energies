package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;
@AllArgsConstructor
@Data
public class CashAdditionResponse {
    private String id;
    private double newBalance;
    private String message;


    // Constructors, getters, and setters
}
