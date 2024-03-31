package com.senior.demo.Service;

import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.VehicleRepository;
import com.senior.demo.Responses.CompanyResponse;
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
    @Autowired
    private CompanyService companyService;
    @Autowired
    private CompanyRepository companyRepository;
    public Vehicle addVehicleForCompany(String companyId, String type, int year, String model, String plateNumber, String driverName, String color) {
        // Get the company by ID
        String customId = generateCustomId();

        CompanyResponse company = companyService.getCompanyById(companyId);
        Company company1 = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Create the vehicle
        Vehicle vehicle = new Vehicle(customId,year, model, plateNumber, driverName, type, color);
        vehicle.setCompany(company);
        company1.addVehicle(vehicle);

        companyRepository.save(company1);
        // Save the vehicle
        return vehicleRepository.save(vehicle);
    }

    // Method to get all vehicles related to a specific company
    public List<Vehicle> getVehiclesForCompany(String companyId) {
        // Get the company by ID
        CompanyResponse company = companyService.getCompanyById(companyId);

        // Get all vehicles associated with the company
        return vehicleRepository.findByCompany(company);
    }

    // Method to update a vehicle related to a specific company
    public Vehicle updateVehicleForCompany(String companyId, String vehicleId, String type, int year, String model, String plateNumber, String driverName, String color) {
        // Get the company by ID

        CompanyResponse company = companyService.getCompanyById(companyId);
        Company company1 = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Check if the vehicle belongs to the company
        Vehicle vehicle = getVehicleForCompany(company, vehicleId);

        // Update the vehicle details
        vehicle.setType(type);
        vehicle.setYear(year);
        vehicle.setModel(model);
        vehicle.setPlateNumber(plateNumber);
        vehicle.setDriverName(driverName);
        vehicle.setColor(color);


        List<Vehicle> vehicles = company1.getVehicles();
        for (Vehicle v : vehicles) {
            if (v.getId().equals(vehicleId)) {
                v.setType(type);
                v.setYear(year);
                v.setModel(model);
                v.setPlateNumber(plateNumber);
                v.setDriverName(driverName);
                v.setColor(color);
                break;
            }
        }
         companyRepository.save(company1);
        // Save the updated vehicle
        return vehicleRepository.save(vehicle);
    }

    // Method to delete a vehicle related to a specific company
    public void deleteVehicleForCompany(String companyId, String vehicleId) {
        // Get the company by ID
        CompanyResponse company = companyService.getCompanyById(companyId);

        // Check if the vehicle belongs to the company
        Vehicle vehicle = getVehicleForCompany(company, vehicleId);
        Company company1 = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        // Delete the vehicle
        vehicleRepository.deleteById(vehicle.getId());
        Vehicle vehicleToRemove = null;
        for (Vehicle vehicle1 : company1.getVehicles()) {
            if (vehicle1.getId().equals(vehicleId)) {
                vehicleToRemove = vehicle1;
                break;
            }
        }

        if (vehicleToRemove != null) {
            // Remove the vehicle from the company's list of vehicles
            company1.removeVehicle(vehicleToRemove);
            companyRepository.save(company1);
            // Delete the vehicle from the database
            vehicleRepository.deleteById(vehicleId);

            // Optionally, you can save the updated company to the database if needed
            // companyRepository.save(company);
        } else {
            // Handle the case when the vehicle is not found for the company
            // You may throw an exception, return null, or handle it differently based on your requirements
        }
    }

    // Helper method to get a vehicle related to a specific company
    private Vehicle getVehicleForCompany(CompanyResponse company, String vehicleId) {
        // Get the vehicle by ID
        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(vehicleId);
        if (optionalVehicle.isPresent()) {
            Vehicle vehicle = optionalVehicle.get();
            // Check if the vehicle belongs to the company
            if (vehicle.getCompany().equals(company)) {
                return vehicle;
            } else {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle not found for the specified company");
            }
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle not found with id: " + vehicleId);
        }
    }



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