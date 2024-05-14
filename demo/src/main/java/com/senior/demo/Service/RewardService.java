package com.senior.demo.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.RedemptionEvent;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.RedemptionEventRepository;
import com.senior.demo.Repository.RewardRepository;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class RewardService {

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private RewardRepository rewardRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private RedemptionEventRepository redemptionEventRepository;
    public List<RedemptionEvent> getRedemptions(){
        try {
            return redemptionEventRepository.findAll();
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch redemptions", e);
        }
    }
    private boolean canRedeemReward(Company company, Reward reward) {
        // Check if the company has enough balance to redeem the reward
        if (company.getPts() < reward.getPts()) {
            return false; // Insufficient balance
        }

        // Check if the reward has already been redeemed by the company
        if (company.hasRedeemedReward(reward.getId())) {
            return false; // Reward already redeemed
        }

        // Add any other custom conditions you want to enforce

        return true; // Reward can be redeemed
    }


    public boolean redeemReward(String companyId, String rewardId) {
        System.out.println(rewardId);
        // Retrieve the company from the database
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));

        // Retrieve the reward from the database
        Reward reward = rewardRepository.findById(rewardId)
                .orElseThrow(() -> new RuntimeException("Reward not found"));

        // Check if the reward can be redeemed (custom logic here, e.g., sufficient balance, not already redeemed)
        if (canRedeemReward(company, reward)) {
            reward.setRedemptionTime(Instant.now());

            // Add the reward to the company's redeemed rewards
            company.getRedeemedRewards().add(reward);
            // Update any necessary data, e.g., subtract points, update balance, etc.
            // Save the updated company to the database

            company.setPts(company.getPts()-reward.getPts());
            companyRepository.save(company);
            return true; // Redemption successful
        } else {
            return false; // Redemption failed
        }
    }

    public String addRewardToAllUsers(Reward reward) {
        String id=generateUniqueRewardId();
        reward.setId(id);

        // Save the reward to the Reward collection
        rewardRepository.save(reward);
        // Retrieve all users
        List<Company> users = companyRepository.findAll();

        // Add the reward to each user's list of rewards
        for (Company user : users) {
            user.getRewards().add(reward);
        }

        // Save each user back to the database
        companyRepository.saveAll(users);
        return id;
    }


    public String generateUniqueRewardId() {
        long id = 1000; // Start from 1000
        while (IdExists("REWARD"+id)) {
            id++;
        }
        return "REWARD"+id;
    }

    private boolean IdExists(String id) {
        Query query = new Query(Criteria.where("id").is(id));
        return mongoTemplate.exists(query, Reward.class);
    }

    public void addRewardToUser(String userId, String rewardId) {
        // Fetch the user from the database
        Optional<Company> optionalUser = companyRepository.findById(userId);
        if (optionalUser.isPresent()) {
            Company company = optionalUser.get();
            Optional<Reward> optionalReward = rewardRepository.findById(rewardId);
            if (optionalReward.isPresent()) {
                Reward reward = optionalReward.get();
                company.getRewards().add(reward);
            }
            // Save the user back to the database
            companyRepository.save(company);
        } else {
            // Handle case where user is not found
//            throw new ChangeSetPersister.NotFoundException();
        }
    }

    private String getJsonResponse(String status, String message) {
        Map<String, String> response = new HashMap<>();
        response.put("status", status);
        response.put("message", message);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(response);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"status\":\"error\",\"message\":\"Error generating JSON response.\"}";
        }
    }


    private boolean isRedeemable(Map<String, LocalDateTime> redemptionTimestamps, String rewardId) {
        LocalDateTime lastRedemptionTimestamp = redemptionTimestamps.get(rewardId);
        if (lastRedemptionTimestamp == null) {
            // Reward has not been redeemed before, so it's redeemable
            return true;
        }

        // Calculate the duration since the last redemption
        LocalDateTime now = LocalDateTime.now();
        long cooldownDurationInDays = 1; // Change as needed
//        LocalDateTime redeemableTimestamp = lastRedemptionTimestamp.plusDays(cooldownDurationInDays);
        LocalDateTime redeemableTimestamp = lastRedemptionTimestamp.plusMinutes(5);

        // Check if the reward is redeemable based on the cooldown period
        return now.isAfter(redeemableTimestamp);
    }
    public List<Reward> getUserRewards(String userId) {
        Company user = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getRewards();
    }
    public List<Reward> getAllRewards(String userId) {
       return rewardRepository.findAll();
    }

    public void updateReward(Reward updatedReward,String rewardId) {
        List<Company> companies = companyRepository.findAll();
        Reward rewardToUpdate = rewardRepository.findById(rewardId).orElse(null);

        for (Company company : companies) {
            // Update rewards list for each company
            List<Reward> rewards = company.getRewards();
            for(Reward reward:rewards){
              if ( reward.getId()==rewardId){
                  reward.setName(rewardToUpdate.getName());
                  reward.setCategory(rewardToUpdate.getCategory());
                  reward.setDescription(rewardToUpdate.getDescription());
                  reward.setPts(rewardToUpdate.getPts());
                  rewardRepository.save(reward);
                }
            }

            companyRepository.save(company);

        }

    }

    // Method to delete a reward from the system
    public void deleteReward(String rewardId) {
        // Find the reward to be deleted
        Reward rewardToDelete = rewardRepository.findById(rewardId).orElse(null);
        if (rewardToDelete != null) {
            // Iterate over each company
            List<Company> companies = companyRepository.findAll();
            for (Company company : companies) {
                // Remove the reward from the company's rewards list
                List<Reward> rewards = company.getRewards();
                rewards.removeIf(reward -> {
                    String id = reward.getId();
                    return id != null && id.equals(rewardId);
                });
                // Set the modified rewards list back to the company
                company.setRewards(rewards);
                // Save the updated company
                companyRepository.save(company);
            }
            // Delete the reward from the repository
            rewardRepository.deleteById(rewardId);
        }
    }


    // Method to redeem a reward for a specific user


    // Method to validate whether a specific reward is valid for redemption
    public boolean validateReward(Reward reward) {
        // Example validation logic: Check if reward point requirement is less than user's points
        return reward.getPts() <= 1000; // Example threshold of 1000 points
    }


    // Method to remove a single reward from a user
    private void removeRewardFromUser(String userId, Reward rewardToRemove) {
        Query query = new Query(Criteria.where("_id").is(userId));
        Update update = new Update().pull("rewards", rewardToRemove);
        mongoTemplate.updateFirst(query, update, Company.class);
    }

    // Method to remove a specific reward from all users
    private void removeRewardFromAllUsers(Reward reward) {
        Query query = new Query();
        Update update = new Update().pull("rewards", reward);
        mongoTemplate.updateMulti(query, update, Company.class);
    }

    // Method to remove all rewards from all users
    public void removeAllRewardsFromAllUsers() {
        Query query = new Query();
        Update update = new Update().unset("rewards");
        mongoTemplate.updateMulti(query, update, Company.class);
        rewardRepository.deleteAll();

    }
    public void addRewardsToUser(String userId, List<Reward> rewards) {
        Company company = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        company.getRewards().addAll(rewards);
        companyRepository.save(company);
    }


    // Method to assign a specific reward to all users
    public void assignRewardToAllUsers(Reward reward) {
        // Ensure that the reward object and its pts property are not null
        if (reward == null ) {
            throw new IllegalArgumentException("Reward and pts property must not be null");
        }

        List<Company> users = companyRepository.findAll();
        for (Company user : users) {
            // Create a new instance of the reward for each user
            Reward userReward = reward;
            user.getRewards().add(userReward);

        }
        // Save all users with their updated rewards lists
        companyRepository.saveAll(users);

    }


}
