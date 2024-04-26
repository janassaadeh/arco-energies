package com.senior.demo.Service;


import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Fuel;
import com.senior.demo.Collections.FuelPrice;
import com.senior.demo.Repository.FuelPriceRepository;
import com.senior.demo.Repository.FuelRepository;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Responses.FuelResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class FuelPriceService {

    @Autowired
    private FuelPriceRepository fuelPriceRepository;

    @Autowired
    private FuelRepository fuelRepository;

    @Autowired
    private FuelService fuelService;

    private static final String FUEL_PRICE_ID_PREFIX = "FUEL_PRICE";

    public FuelPrice addFuelPriceWithCustomId(String fuelType, double price, LocalDate createdDate) {
        // Retrieve the Fuel entity by its type
        Fuel fuel = fuelRepository.findByType(fuelType);
        if (fuel == null) {
            // Handle case where Fuel with given type doesn't exist
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel type '" + fuelType + "' not found");
        }
        FuelResponse fuelResponse = fuelService.getFuelResponseByType(fuelType);

        // Create a new FuelPrice object
        String customId = generateCustomId();
        FuelPrice fuelPrice = new FuelPrice(customId, price, createdDate);

        // Add the new FuelPrice to the list of prices associated with the Fuel
        List<FuelPrice> fuelPrices = fuel.getPrices();
        fuelPrices.add(fuelPrice);
        fuel.setPrices(fuelPrices);
        fuelPrice.setFuel(fuelResponse);

        // Save the FuelPrice entity
        FuelPrice savedFuelPrice = fuelPriceRepository.save(fuelPrice);

        // Save or update the Fuel entity
        fuelRepository.save(fuel);

        // Return the saved FuelPrice
        return savedFuelPrice;
    }

    public FuelPrice getFuelPriceById(String id) {
        Optional<FuelPrice> optionalFuelPrice = fuelPriceRepository.findById(id);
        if (optionalFuelPrice.isPresent()) {
            return optionalFuelPrice.get();
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel Price not found with id: " + id);
        }
    }

    public List<FuelPrice> getAllFuelPrices() {
        return fuelPriceRepository.findAll();
    }

    public void deleteFuelPriceById(String id) {
        Optional<FuelPrice> optionalFuelPrice = fuelPriceRepository.findById(id);
        if (optionalFuelPrice.isPresent()) {
            fuelPriceRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel Price not found with id: " + id);
        }
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