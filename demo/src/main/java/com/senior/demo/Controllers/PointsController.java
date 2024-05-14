package com.senior.demo.Controllers;

import com.senior.demo.Collections.Reward;
import com.senior.demo.Collections.User;
import com.senior.demo.Responses.CashAdditionResponse;
import com.senior.demo.Responses.ErrorResponse;
import com.senior.demo.Service.PointsService;
import com.senior.demo.requestClasses.AddCashRequestDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

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
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authenticatoion failed");
    }


    @PostMapping("/deduct")
    public ResponseEntity<String> deductPoints(@RequestParam String companyId, @RequestParam int pointsToDeduct) {
        pointsService.deductPoints(companyId, pointsToDeduct);
        return ResponseEntity.ok("Points deducted successfully");
    }
//
//    @PostMapping("/redeem")
//    public ResponseEntity<Object> redeemReward(@RequestParam String userId, @RequestBody Reward reward,Authentication authentication) {
//
//        try{
//            Map<String, Object> result =  pointsService.redeemReward(userId, reward,authentication);
//
//            double newPtsBalance = (double) result.get("newPtsBalance");
//            String redemptionEventId = (String) result.get("redemptionEventId");
//
//            CashAdditionResponse response = new CashAdditionResponse( redemptionEventId,newPtsBalance, "Reward redeemed successfully.");
//            return ResponseEntity.status(HttpStatus.OK).body(response);
//        } catch (Exception e) {
//            ErrorResponse errorResponse = new ErrorResponse("Failed to add redeem reward: " + e.getMessage());
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
//        }
//    }
//    @PostMapping("/addCash")
//    public ResponseEntity<Object> addCashToCompany(@RequestBody AddCashRequestDTO requestDTO, Authentication authentication) {
//        try {
//            Map<String, Object> result = addDepositService.addCashAndSendEmail(requestDTO.getCompanyId(), requestDTO.getCashAmount(), requestDTO.getPaymentMethod(), authentication);
//
//            double newBalance = (double) result.get("newBalance");
//            String cashAdditionEventId = (String) result.get("cashAdditionEventId");
//
//            CashAdditionResponse response = new CashAdditionResponse( cashAdditionEventId,newBalance, "Cash added successfully.");
//            return ResponseEntity.status(HttpStatus.OK).body(response);
//        } catch (Exception e) {
//            ErrorResponse errorResponse = new ErrorResponse("Failed to add cash and send email: " + e.getMessage());
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
//        }
//    }
    // Add additional endpoints as needed
}
