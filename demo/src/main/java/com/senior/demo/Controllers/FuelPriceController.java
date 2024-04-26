package com.senior.demo.Controllers;

import com.senior.demo.Collections.FuelPrice;
import com.senior.demo.Service.FuelPriceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class FuelPriceController {

    @Autowired
    private FuelPriceService fuelPriceService;

    @PostMapping("/fuel_prices")
    public FuelPrice addFuelPrice(@RequestBody FuelPrice newFuelPrice, @RequestParam String fuelType) {
        return fuelPriceService.addFuelPriceWithCustomId(fuelType, newFuelPrice.getPrice(), newFuelPrice.getCreatedDate());
    }

    @GetMapping("/fuel_prices/{id}")
    public FuelPrice getFuelPriceById(@PathVariable String id) {
        return fuelPriceService.getFuelPriceById(id);
    }

    @GetMapping("/fuel_prices")
    public List<FuelPrice> getAllFuelPrices() {
        return fuelPriceService.getAllFuelPrices();
    }

    @DeleteMapping("/fuel_prices/{id}")
    public void deleteFuelPriceById(@PathVariable String id) {
        fuelPriceService.deleteFuelPriceById(id);
    }
}
