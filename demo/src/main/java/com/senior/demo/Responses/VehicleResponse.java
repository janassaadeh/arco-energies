package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Field;

@AllArgsConstructor
@Data
public class VehicleResponse {

    String id;

    int year;

    String model;

    String plateNumber;

    String driverName;

    String type;

    String color;

    CompanyResponse company;
}
