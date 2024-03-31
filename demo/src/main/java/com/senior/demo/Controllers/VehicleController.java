package com.senior.demo.Controllers;


import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @PostMapping("/vehicles")
    public Vehicle addVehicle(@RequestBody Vehicle newVehicle) {
        return vehicleService.addVehicleWithCustomId(newVehicle.getType(), newVehicle.getYear(), newVehicle.getModel(), newVehicle.getPlateNumber(), newVehicle.getDriverName(), newVehicle.getColor());
    }
    @GetMapping("/vehicles")
    public List<Vehicle> getAllVehicles() {
        return vehicleService.getAllVehicles();
    }

    @GetMapping("/vehicles/{id}")
    public Vehicle getVehicleById(@PathVariable String id) {
        return vehicleService.getVehicleById(id);
    }

    @PutMapping("/vehicles/{id}")
    public Vehicle updateVehicle(@PathVariable String id, @RequestBody Vehicle updatedVehicle) {
        return vehicleService.updateVehicle(id, updatedVehicle.getType(), updatedVehicle.getYear(), updatedVehicle.getModel(), updatedVehicle.getPlateNumber(), updatedVehicle.getDriverName());
    }

    @DeleteMapping("/vehicles/{id}")
    public void deleteVehicle(@PathVariable String id) {
        vehicleService.deleteVehicleById(id);
    }


    @PostMapping("/vehicles/company/{companyId}")
    public ResponseEntity<Vehicle> addVehicleForCompany(@PathVariable String companyId,
                                                        @RequestParam String type,
                                                        @RequestParam int year,
                                                        @RequestParam String model,
                                                        @RequestParam String plateNumber,
                                                        @RequestParam String driverName,
                                                        @RequestParam String color) {
        Vehicle vehicle = vehicleService.addVehicleForCompany(companyId, type, year, model, plateNumber, driverName, color);
        return new ResponseEntity<>(vehicle, HttpStatus.CREATED);
    }

    @GetMapping("/vehicles/company/{companyId}")
    public ResponseEntity<List<Vehicle>> getVehiclesForCompany(@PathVariable String companyId) {
        List<Vehicle> vehicles = vehicleService.getVehiclesForCompany(companyId);
        return new ResponseEntity<>(vehicles, HttpStatus.OK);
    }

    @PutMapping("/vehicles/company/{companyId}/vehicle/{vehicleId}")
    public ResponseEntity<Vehicle> updateVehicleForCompany(@PathVariable String companyId,
                                                           @PathVariable String vehicleId,
                                                           @RequestParam String type,
                                                           @RequestParam int year,
                                                           @RequestParam String model,
                                                           @RequestParam String plateNumber,
                                                           @RequestParam String driverName,
                                                           @RequestParam String color) {
        Vehicle updatedVehicle = vehicleService.updateVehicleForCompany(companyId, vehicleId, type, year, model, plateNumber, driverName, color);
        return new ResponseEntity<>(updatedVehicle, HttpStatus.OK);
    }

    @DeleteMapping("/vehicles/company/{companyId}/vehicle/{vehicleId}")
    public ResponseEntity<Void> deleteVehicleForCompany(@PathVariable String companyId,
                                                        @PathVariable String vehicleId) {
        vehicleService.deleteVehicleForCompany(companyId, vehicleId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
