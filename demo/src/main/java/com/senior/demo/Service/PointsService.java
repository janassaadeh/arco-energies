package com.senior.demo.Service;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.RedemptionEvent;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.RedemptionEventRepository;
import com.senior.demo.Repository.RewardRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class PointsService {
    private final UserService userService;
    @Autowired
    private CompanyRepository companyRepository;
    @Autowired
    private RewardRepository rewardRepository;
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private RedemptionEventRepository redemptionEventRepository;
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
    public Map<String, Object> redeemReward(String userId, String  rewardId,Authentication authentication) {
        Company company = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Reward reward = rewardRepository.findById(rewardId)
                .orElseThrow(() -> new RuntimeException("Reward not found"));
        int pointsRequiredForReward = reward.getPts();
        int pointsBalance = company.getPts();
        if (pointsBalance < pointsRequiredForReward) {
            throw new RuntimeException("Insufficient points balance to redeem the reward");
        }
        // Deduct points for the redeemed reward
        company.setPts(pointsBalance - pointsRequiredForReward);
        company.getRedeemedRewards().add(reward);
        companyRepository.save(company);
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new RuntimeException("Operator not found");
        }
        CompanyResponse companyResponse=new CompanyResponse(company.getId(),company.getEmail(),company.getPhone(),company.getName(),company.getBalance(),company.getContactName(),company.getLocation(),company.getPts(),company.getImageId(),company.isActivated());
        String id=generateUniqueRedemptionId();
        RedemptionEvent redemptionEvent=new RedemptionEvent(
                id,
                companyResponse,
                operator,
                reward,
                reward.getPts(),
                LocalDateTime.now()
                );
        redemptionEventRepository.save(redemptionEvent);
                Map<String, Object> result = new HashMap<>();
        result.put("newPtsBalance", pointsBalance - pointsRequiredForReward);
        result.put("redemptionEventId", id);
        return result;

        // Other reward redemption logic can go here (e.g., sending confirmation email)
    }

    public String generateUniqueRedemptionId() {
        long id = 1000; // Start from 1000
        while (redemptionIdExists("REDEMPTION"+id)) {
            id++;
        }
        return "REDEMPTION"+id;
    }
    private boolean redemptionIdExists(String id) {
        Query query = new Query(Criteria.where("id").is(id));
        return mongoTemplate.exists(query, RedemptionEvent.class);
    }

//    public Map<String, Object> addCashAndSendEmail(String companyId, double cashAmount, String paymentMethod, Authentication authentication) {
//        Company company = companyRepository.findById(companyId)
//                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
//
//        double currentBalance = company.getBalance();
//        double newBalance = currentBalance + cashAmount;
//        company.setBalance(newBalance);
//        companyRepository.save(company);
//
//        AdminResponse admin = userService.getAdmin(authentication);
//        if (admin == null) {
//            throw new RuntimeException("Admin not found");
//        }
//
//        // Save cash addition event
//        String id = generateUniqueCashId();
//        CashAdditionEvent cashAdditionEvent = new CashAdditionEvent(
//                id,
//                companyService.getCompanyById(companyId),
//                admin,
//                paymentMethod,
//                cashAmount,
//                LocalDateTime.now()
//        );
//        cashAdditionEventRepository.save(cashAdditionEvent);
//        sendBalanceUpdatedEmail(company);
//
//        Map<String, Object> result = new HashMap<>();
//        result.put("newBalance", newBalance);
//        result.put("cashAdditionEventId", id);
//        return result;
//    }
}
