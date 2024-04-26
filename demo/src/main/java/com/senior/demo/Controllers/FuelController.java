package com.senior.demo.Controllers;

import com.senior.demo.Collections.Fuel;
import com.senior.demo.Service.FuelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class FuelController {

    @Autowired
    private FuelService fuelService;

    @PostMapping("/fuels")
    public Fuel addFuel(@RequestBody Fuel newFuel) {
        return fuelService.addFuelWithCustomId(newFuel.getType(), newFuel.getDescription());
    }

    @PutMapping("/fuels/{fuelId}")
    public ResponseEntity<Fuel> updateFuelTypeAndDescription(@PathVariable String fuelId, @RequestBody FuelUpdateRequest request) {
        Fuel updatedFuel = fuelService.updateFuelTypeAndDescription(fuelId, request.getType(), request.getDescription());
        return ResponseEntity.ok(updatedFuel);
    }

    @GetMapping("/fuels/{fuelId}")
    public ResponseEntity<Fuel> getFuelById(@PathVariable String fuelId) {
        Fuel fuel = fuelService.getFuelById(fuelId);
        return ResponseEntity.ok(fuel);
    }

    @GetMapping("/fuels")
    public ResponseEntity<List<Fuel>> getAllFuels() {
        List<Fuel> fuels = fuelService.getAllFuels();
        return ResponseEntity.ok(fuels);
    }

    @DeleteMapping("/fuels/{fuelId}")
    public ResponseEntity<?> deleteFuelById(@PathVariable String fuelId) {
        fuelService.deleteFuelById(fuelId);
        return ResponseEntity.ok().build();
    }

    public static class FuelUpdateRequest {
        private String type;
        private String description;

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }
    }
}
