package com.senior.demo.Service;

import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Repository.CompanyRepository;
import org.springframework.stereotype.Service;

import java.util.Set;
@Service
public class DiscountCalculationService {

CompanyRepository companyRepository;
    public double calculateDiscount(String companyId) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Set<Reward> redeemedRewards = company.getRedeemedRewards();
        
        // Check if the company has redeemed rewards
        if (!redeemedRewards.isEmpty()) {
            // Iterate over redeemed rewards to find the discount reward
            for (Reward reward : redeemedRewards) {
                if (reward.getCategory().equalsIgnoreCase("discount")) {
                    // Extract discount amount from the reward title
                    String title = reward.getName();
                    // Assuming the discount title format is "<amount>% discount"
                    int percentageIndex = title.indexOf('%');
                    if (percentageIndex != -1) {
                        try {
                            // Extract the discount amount from the title
                            String discountAmountString = title.substring(0, percentageIndex);
                            return Double.parseDouble(discountAmountString);
                        } catch (NumberFormatException e) {
                            // Handle invalid format
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return 0; // Return 0 if no discount found or invalid format
    }
}
