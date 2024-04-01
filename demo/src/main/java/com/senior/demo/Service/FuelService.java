package com.senior.demo.Service;


import com.senior.demo.Collections.Fuel;
import com.senior.demo.Collections.FuelPrice;
import com.senior.demo.Collections.Pump;
import com.senior.demo.Repository.FuelRepository;
import com.senior.demo.Responses.FuelResponse;
import com.senior.demo.Responses.PumpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
public class FuelService {

    @Autowired
    private FuelRepository fuelRepository;

    private static final String FUEL_ID_PREFIX = "FUEL";

    public Fuel getFuelByType(String type) {
        return fuelRepository.findByType(type);
    }

    public Fuel addFuelWithCustomId(String type, String description) {
        String customId = generateCustomId();
        Fuel fuel = new Fuel(customId, type, description);
        return fuelRepository.save(fuel); // Use default save method
    }

    public Fuel updateFuelTypeAndDescription(String fuelId, String type, String description) {
        // Retrieve the existing fuel entity by its ID
        Optional<Fuel> optionalFuel = fuelRepository.findById(fuelId);
        if (optionalFuel.isPresent()) {
            Fuel existingFuel = optionalFuel.get();
            // Update the type and description using the provided method
            existingFuel.updateTypeAndDescription(type, description);
            // Save the updated fuel entity
            return fuelRepository.save(existingFuel);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel with id: '" + fuelId + "' is not found");
        }
    }

    private synchronized String generateCustomId() {
        // Fetch all existing fuels from the database
        List<Fuel> allFuels = fuelRepository.findAll();

        // Determine the maximum ID among the existing fuels
        int maxId = 999;
        for (Fuel fuel : allFuels) {
            String id = fuel.getId();
            int numericPart = Integer.parseInt(id.replace(FUEL_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        // Increment the maximum ID by 1 to generate the next custom ID
        int nextId = maxId + 1;

        // Generate the next custom ID
        return FUEL_ID_PREFIX + nextId;
    }

    public FuelResponse getFuelResponseById(String id) {
        // Retrieve the Fuel object by its ID
        Optional<Fuel> optionalFuel = fuelRepository.findById(id);
        if (!optionalFuel.isPresent()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel with id: '" + id + "' not found");
        }
        Fuel fuel = optionalFuel.get();

        // Get the prices list from the Fuel object
        List<FuelPrice> prices = fuel.getPrices();

        // Check if prices list is empty
        if (prices.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel prices list is empty for fuel with id: '" + id + "'");
        }

        // Get the last added FuelPrice object from the prices list
        FuelPrice lastFuelPrice = prices.get(prices.size() - 1);

        // Get the price field from the last added FuelPrice object
        double fuelPrice = lastFuelPrice.getPrice();

        // Create and return a FuelResponse object
        FuelResponse fuelResponse = new FuelResponse(fuel.getId(), fuel.getType(), fuel.getDescription(), fuelPrice);
        return fuelResponse;
    }
}