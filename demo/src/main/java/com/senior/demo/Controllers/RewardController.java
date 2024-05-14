package com.senior.demo.Controllers;

import com.senior.demo.Collections.RedemptionEvent;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Repository.RewardRepository;
import com.senior.demo.Responses.CashAdditionResponse;
import com.senior.demo.Responses.ErrorResponse;
import com.senior.demo.Service.PointsService;
import com.senior.demo.Service.RewardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/rewards")
public class RewardController {

    @Autowired
    private RewardService rewardService;
    @Autowired
    private PointsService pointsService;
    @Autowired
    private RewardRepository rewardRepository;
    @GetMapping("/redemptions")
    public List<RedemptionEvent> redemptions() {
        return rewardService.getRedemptions();
    }
    @PostMapping("/assign/{userId}")
    public void assignRewardsToUser(@PathVariable String userId, @RequestBody String rewardId) {
        rewardService.addRewardToUser(userId, rewardId);
    }

    @PostMapping("/assign/all")
    public Object addRewardToAllUsers(@RequestBody Reward reward) {
        // Log the received Reward object
        System.out.println("Received Reward: " + reward);

        // Pass the reward object to the service method
        String response=rewardService.addRewardToAllUsers(reward);
        return ResponseEntity.status(HttpStatus.OK).body(response);

    }

    @GetMapping("/user/{userId}")
    public List<Reward> getUserRewards(@PathVariable String userId) {
        return rewardService.getUserRewards(userId);
    }

    @GetMapping
    public List<Reward> getRewards() {
        return rewardRepository.findAll();
    }

    @PutMapping("/update/{rewardId}")
    public void updateReward(@RequestBody Reward updatedReward,@PathVariable String rewardId) {
        rewardService.updateReward(updatedReward,rewardId);
    }

    @DeleteMapping("/delete/{rewardId}")
    public void deleteReward(@PathVariable String rewardId) {
        rewardService.deleteReward(rewardId);
    }

    @PostMapping("/redeem/{userId}")
    public Object redeemReward(@PathVariable String userId, @RequestParam String rewardId, Authentication authentication) {
        try{
            Map<String, Object> result =  pointsService.redeemReward(userId, rewardId,authentication);

            int newPtsBalance = (int) result.get("newPtsBalance");
            String redemptionEventId = (String) result.get("redemptionEventId");

            CashAdditionResponse response = new CashAdditionResponse( redemptionEventId,newPtsBalance, "Reward redeemed successfully.");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            ErrorResponse errorResponse = new ErrorResponse("Failed to add redeem reward: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }    }

    @DeleteMapping("/delete-all")
    public void deleteRewards() {
        rewardService.removeAllRewardsFromAllUsers();
    }

    @GetMapping("/validate")
    public boolean validateReward(@RequestBody Reward reward) {
        return rewardService.validateReward(reward);
    }}

