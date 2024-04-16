package com.senior.demo.Service;

import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.List;

@Component
public class RewardExpirationTask {

    @Autowired
    private CompanyRepository companyRepository;

    private static final long EXPIRATION_TIME_MILLIS = 2 * 60 * 1000; // 2 minutes

    @Scheduled(fixedRate = 60000) // Runs every minute
    public void removeExpiredRewards() {
        List<Company> companies = companyRepository.findAll();
        
        for (Company company : companies) {
            Instant now = Instant.now();
            company.getRedeemedRewards().removeIf(reward -> {
                Instant redemptionTime = reward.getRedemptionTime();
                return redemptionTime != null && now.minusMillis(EXPIRATION_TIME_MILLIS).isAfter(redemptionTime);
            });
            companyRepository.save(company);
        }
    }
}
