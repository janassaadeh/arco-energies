package com.senior.demo.Controllers;


import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
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
}
