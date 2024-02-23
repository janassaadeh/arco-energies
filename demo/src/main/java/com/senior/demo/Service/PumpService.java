package com.senior.demo.Service;


import com.senior.demo.Collections.Fuel;
import com.senior.demo.Collections.Pump;
import com.senior.demo.Repository.FuelRepository;
import com.senior.demo.Repository.PumpRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class PumpService {

    @Autowired
    private PumpRepository pumpRepository;

    @Autowired
    private FuelRepository fuelRepository;

    private static final String PUMP_ID_PREFIX = "PUMP";

    public Pump addPumpWithCustomId(String fuelType, String name, String status) {

        // Retrieve the Fuel entity by its type
        Fuel fuel = fuelRepository.findByType(fuelType);
        if (fuel == null) {
            // Handle case where Fuel with given type doesn't exist
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Fuel type '" + fuelType + "' not found");
        }

        // Create a new Pump Object
        String customId = generateCustomId();
        Pump pump = new Pump(customId, name, status);

        // Add the new Pump to the list of pumps associated with the Fuel
        List<Pump> pumps = fuel.getPumps();
        pumps.add(pump);
        fuel.setPumps(pumps);

        // Save the Pump entity
        Pump savedPump = pumpRepository.save(pump);

        // Update the Fuel entity
        fuelRepository.save(fuel);

        return savedPump;


    }

    private synchronized String generateCustomId() {
        // Fetch all existing pumps from the database
        List<Pump> allPumps = pumpRepository.findAll();

        // Determine the maximum ID among the existing pumps
        int maxId = 999;
        for (Pump pump : allPumps) {
            String id = pump.getId();
            int numericPart = Integer.parseInt(id.replace(PUMP_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        // Increment the maximum ID by 1 to generate the next custom ID
        int nextId = maxId + 1;

        // Generate the next custom ID
        return PUMP_ID_PREFIX + nextId;
    }
}
