package com.senior.demo.Service;

import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PointsService {
    private final UserService userService;
    @Autowired
    private CompanyRepository companyRepository;

    public PointsService(UserService userService) {
        this.userService = userService;
    }

    // Method to add points to a user's balance
    public void addPoints(String userId, int pointsToAdd) {
        Company company = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        company.setPts(company.getPts() + pointsToAdd);
        companyRepository.save(company);
    }

    // Method to deduct points from a user's balance
    public void deductPoints(String companyId, int pointsToDeduct) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        int updatedPointsBalance = company.getPts() - pointsToDeduct;
        if (updatedPointsBalance < 0) {
            throw new RuntimeException("Insufficient points balance");
        }
        company.setPts(updatedPointsBalance);
        companyRepository.save(company);
    }

    // Method to redeem a reward for a user
    public void redeemReward(String userId, Reward reward) {
        Company company = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        int pointsRequiredForReward = reward.getPts();
        int pointsBalance = company.getPts();
        if (pointsBalance < pointsRequiredForReward) {
            throw new RuntimeException("Insufficient points balance to redeem the reward");
        }
        // Deduct points for the redeemed reward
        company.setPts(pointsBalance - pointsRequiredForReward);
        company.getRedeemedRewards().add(reward);
        companyRepository.save(company);
        // Other reward redemption logic can go here (e.g., sending confirmation email)
    }

}
