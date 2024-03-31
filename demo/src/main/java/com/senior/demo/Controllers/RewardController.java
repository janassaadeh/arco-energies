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
    public void assignRewardsToUser(@PathVariable String userId, @RequestBody Reward reward) {
        rewardService.addRewardToUser(userId, reward);
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

    @GetMapping("/available")
    public List<Reward> getAvailableRewards() {
        return rewardService.getAvailableRewards();
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
    public void redeemReward(@PathVariable String userId, @RequestBody Reward redeemedReward) {
        rewardService.redeemReward(userId, redeemedReward);
    }

    @GetMapping("/validate")
    public boolean validateReward(@RequestBody Reward reward) {
        return rewardService.validateReward(reward);
    }
//
//    @GetMapping("/search")
//    public List<Reward> searchRewards(@RequestParam String keyword) {
//        return rewardService.searchRewards(keyword);
//    }
//
//    @GetMapping("/sort")
//    public List<Reward> sortRewardsByNameAsc() {
//        return rewardService.sortRewardsByNameAsc();
//    }
//
//    @GetMapping("/filter")
//    public List<Reward> filterRewardsByCategory(@RequestParam String category) {
//        return rewardService.filterRewardsByCategory(category);
//    }
//
//    @GetMapping("/export")
//    public void exportRewardsToCSV() {
//        rewardService.exportRewardsToCSV();
//    }
}
