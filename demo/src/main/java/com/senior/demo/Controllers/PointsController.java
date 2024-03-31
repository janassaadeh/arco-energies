package com.senior.demo.Controllers;

import com.senior.demo.Collections.Reward;
import com.senior.demo.Collections.User;
import com.senior.demo.Service.PointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/points")
public class PointsController {

    @Autowired
    private PointsService pointsService;

    @PostMapping("/add")
    public ResponseEntity<String> addPoints(Authentication authentication, @RequestParam int pointsToAdd) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            User user = (User) authentication.getPrincipal();
            pointsService.addPoints(user.getId(), pointsToAdd);
            return ResponseEntity.ok("Points added successfully");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication failed");
    }


    @PostMapping("/deduct")
    public ResponseEntity<String> deductPoints(@RequestParam String companyId, @RequestParam int pointsToDeduct) {
        pointsService.deductPoints(companyId, pointsToDeduct);
        return ResponseEntity.ok("Points deducted successfully");
    }

    @PostMapping("/redeem")
    public ResponseEntity<String> redeemReward(@RequestParam String userId, @RequestBody Reward reward) {
        pointsService.redeemReward(userId, reward);
        return ResponseEntity.ok("Reward redeemed successfully");
    }

    // Add additional endpoints as needed
}
