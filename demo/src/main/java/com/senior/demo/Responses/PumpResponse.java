package com.senior.demo.Responses;

import com.senior.demo.Collections.Fuel;
import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class PumpResponse {
    String id;

    String name;

    String currency;

    String status;

    // ManyToOne
    FuelResponse fuel;
}
