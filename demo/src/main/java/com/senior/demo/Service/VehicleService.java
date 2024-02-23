package com.senior.demo.Service;

import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VehicleService {
    @Autowired
    private VehicleRepository vehicleRepository;

    private static final String VEHICLE_ID_PREFIX = "VEHICLE";

    public Vehicle addVehicleWithCustomId(String type, int year, String model, String make, String plateNumber, String driverName) {
        String customId = generateCustomId();
        Vehicle vehicle = new Vehicle(customId, year, model, make, plateNumber, driverName, type);
        return vehicleRepository.save(vehicle);
    }

    private synchronized String generateCustomId() {

        List<Vehicle> allVehicles = vehicleRepository.findAll();

        int maxId = 999;
        for (Vehicle vehicle : allVehicles) {
            String id = vehicle.getId();
            int numericPart = Integer.parseInt(id.replace(VEHICLE_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        int nextId = maxId + 1;

        return VEHICLE_ID_PREFIX + nextId;
    }
}