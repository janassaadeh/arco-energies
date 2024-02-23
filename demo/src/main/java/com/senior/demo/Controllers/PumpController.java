package com.senior.demo.Controllers;


import com.senior.demo.Collections.Pump;
import com.senior.demo.Service.PumpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/custom_api")
public class PumpController {

    @Autowired
    private PumpService pumpService;

    @PostMapping("/pumps")
    public Pump addPump(@RequestBody PumpRequest newPumpRequest, @RequestParam String fuelType) {
        return pumpService.addPumpWithCustomId(fuelType, newPumpRequest.getName(), newPumpRequest.getStatus());
    }


    static class PumpRequest {
        private String name;
        private String status;

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
    }
}