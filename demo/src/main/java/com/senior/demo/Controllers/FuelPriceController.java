package com.senior.demo.Controllers;

import com.senior.demo.Collections.FuelPrice;
import com.senior.demo.Service.FuelPriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/custom_api")
public class FuelPriceController {

    @Autowired
    private FuelPriceService fuelPriceService;

    @PostMapping("/fuel_prices")
    public FuelPrice addFuelPrice(@RequestBody FuelPrice newFuelPrice, @RequestParam String fuelType) {
        return fuelPriceService.addFuelPriceWithCustomId(fuelType, newFuelPrice.getPrice(), newFuelPrice.getCreatedDate());
    }
}
