package com.senior.demo.Controllers;


import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/custom_api")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @PostMapping("/vehicles")
    public Vehicle addVehicle(@RequestBody Vehicle newVehicle) {
        return vehicleService.addVehicleWithCustomId(newVehicle.getType(), newVehicle.getYear(), newVehicle.getModel(), newVehicle.getMake(), newVehicle.getPlateNumber(), newVehicle.getDriverName());
    }
}
