package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class FuelResponse {
    String id;
    String type;
    String description;
    double fuelPrice;
}
