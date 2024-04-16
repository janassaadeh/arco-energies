package com.senior.demo.Controllers;

import com.senior.demo.Collections.Reward;
import com.senior.demo.Service.RewardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/rewards")
public class RewardController {

    @Autowired
    private RewardService rewardService;

    @PostMapping("/assign/{userId}")
    public void assignRewardsToUser(@PathVariable String userId, @RequestBody String rewardId) {
        rewardService.addRewardToUser(userId, rewardId);
    }

    @PostMapping("/assign/all")
    public void addRewardToAllUsers(@RequestBody Reward reward) {
        // Log the received Reward object
        System.out.println("Received Reward: " + reward);

        // Pass the reward object to the service method
        rewardService.addRewardToAllUsers(reward);
    }

    @GetMapping("/user/{userId}")
    public List<Reward> getUserRewards(@PathVariable String userId) {
        return rewardService.getUserRewards(userId);
    }


    @PutMapping("/update")
    public void updateReward(@RequestBody Reward updatedReward) {
        rewardService.updateReward(updatedReward);
    }

    @DeleteMapping("/delete/{rewardId}")
    public void deleteReward(@PathVariable String rewardId) {
        rewardService.deleteReward(rewardId);
    }

    @PostMapping("/redeem/{userId}")
    public void redeemReward(@PathVariable String userId, @RequestParam String rewardId) {
        rewardService.redeemReward(userId, rewardId);
    }

    @DeleteMapping("/delete-all")
    public void deleteRewards() {
        rewardService.removeAllRewardsFromAllUsers();
    }

    @GetMapping("/validate")
    public boolean validateReward(@RequestBody Reward reward) {
        return rewardService.validateReward(reward);
    }}

