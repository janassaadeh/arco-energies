package com.senior.demo.Service;


import com.senior.demo.Collections.Fuel;
import com.senior.demo.Collections.FuelPrice;
import com.senior.demo.Repository.FuelPriceRepository;
import com.senior.demo.Repository.FuelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.List;

@Service
public class FuelPriceService {

    @Autowired
    private FuelPriceRepository fuelPriceRepository;

    @Autowired
    private FuelRepository fuelRepository;

    private static final String FUEL_PRICE_ID_PREFIX = "FUEL_PRICE";

    public FuelPrice addFuelPriceWithCustomId(String fuelType, double price, LocalDate createdDate) {
        // Retrieve the Fuel entity by its type
        Fuel fuel = fuelRepository.findByType(fuelType);
        if (fuel == null) {
            // Handle case where Fuel with given type doesn't exist
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel type '" + fuelType + "' not found");
        }

        // Create a new FuelPrice object
        String customId = generateCustomId();
        FuelPrice fuelPrice = new FuelPrice(customId, price, createdDate);

        // Add the new FuelPrice to the list of prices associated with the Fuel
        List<FuelPrice> fuelPrices = fuel.getPrices();
        fuelPrices.add(fuelPrice);
        fuel.setPrices(fuelPrices);

        // Save the FuelPrice entity
        FuelPrice savedFuelPrice = fuelPriceRepository.save(fuelPrice);

        // Save or update the Fuel entity
        fuelRepository.save(fuel);

        // Return the saved FuelPrice
        return savedFuelPrice;
    }

    private synchronized String generateCustomId() {
        // Fetch all existing fuel prices from the database
        List<FuelPrice> allFuelPrices = fuelPriceRepository.findAll();

        // Determine the maximum ID among the existing fuel prices
        int maxId = 999;
        for (FuelPrice fuelPrice : allFuelPrices) {
            String id = fuelPrice.getId();
            int numericPart = Integer.parseInt(id.replace(FUEL_PRICE_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        // Increment the maximum ID by 1 to generate the next custom ID
        int nextId = maxId + 1;

        // Generate the next custom ID
        return FUEL_PRICE_ID_PREFIX + nextId;
    }
}