package com.senior.demo.Controllers;


import com.senior.demo.Collections.Pump;
import com.senior.demo.Service.PumpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class PumpController {

    @Autowired
    private PumpService pumpService;

    @PostMapping("/pumps")
    public Pump addPump(@RequestBody PumpRequest newPumpRequest, @RequestParam String fuelType) {
        return pumpService.addPumpWithCustomId(fuelType, newPumpRequest.getName(), newPumpRequest.getStatus(), newPumpRequest.getPetrolType(), newPumpRequest.getCurrency());
    }

    @GetMapping("/pumps")
    public List<Pump> getAllPumps() {
        return pumpService.getAllPumps();
    }

    @GetMapping("/pumps/{id}")
    public Pump getPumpById(@PathVariable String id) {
        return pumpService.getPumpById(id);
    }

    @DeleteMapping("/pumps/{id}")
    public void deletePumpById(@PathVariable String id) {
        pumpService.deletePumpById(id);
    }

    static class PumpRequest {
        private String name;
        private String status;

        private String petrolType;

        private String currency;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getPetrolType() {
            return petrolType;
        }

        public void setPetrolType(String petrolType) {
            this.petrolType = petrolType;
        }

        public String getCurrency() {
            return currency;
        }

        public void setCurrency(String currency) {
            this.currency = currency;
        }
    }
}