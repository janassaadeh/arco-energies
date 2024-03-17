package com.senior.demo.Service;

import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
public class VehicleService {
    @Autowired
    private VehicleRepository vehicleRepository;

    private static final String VEHICLE_ID_PREFIX = "VEHICLE";

    public List<Vehicle> getAllVehicles() {
        return vehicleRepository.findAll();
    }

    public Vehicle getVehicleById(String id) {
        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(id);
        if (optionalVehicle.isPresent()) {
            return optionalVehicle.get();
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle not found with id: " + id);
        }
    }

    public Vehicle addVehicleWithCustomId(String type, int year, String model, String plateNumber, String driverName, String color) {
        String customId = generateCustomId();
        Vehicle vehicle = new Vehicle(customId, year, model, plateNumber, driverName, type, color);
        return vehicleRepository.save(vehicle);
    }

    public void deleteVehicleById(String id) {
        if (vehicleRepository.existsById(id)) {
            vehicleRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle not found with id: " + id);
        }
    }

    public Vehicle updateVehicle(String id, String type, int year, String model, String plateNumber, String driverName) {
        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(id);
        if (optionalVehicle.isPresent()) {
            Vehicle vehicle = optionalVehicle.get();
            vehicle.setType(type);
            vehicle.setYear(year);
            vehicle.setModel(model);
            vehicle.setPlateNumber(plateNumber);
            vehicle.setDriverName(driverName);
            return vehicleRepository.save(vehicle);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle not found with id: " + id);
        }
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