package com.senior.demo.Service;

import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Collections.User;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.RewardRepository;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RewardService {

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private RewardRepository rewardRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    // Method to retrieve all rewards associated with a specific user
    public void addRewardToAllUsers(Reward reward) {
        // Save the reward to the Reward collection
        rewardRepository.save(reward);
        reward.setId(generateUniqueRewardId());
        // Retrieve all users
        List<Company> users = companyRepository.findAll();

        // Add the reward to each user's list of rewards
        for (Company user : users) {
            user.getRewards().add(reward);
        }

        // Save each user back to the database
        companyRepository.saveAll(users);
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

    public void addRewardToUser(String userId, Reward reward) {
        // Fetch the user from the database
        Optional<Company> optionalUser = companyRepository.findById(userId);
        if (optionalUser.isPresent()) {
            Company company = optionalUser.get();
            rewardRepository.save(reward);
            reward.setId(generateUniqueRewardId());
            // Add the reward to the user's list of rewards
            company.getRewards().add(reward);

            // Save the user back to the database
            companyRepository.save(company);
        } else {
            // Handle case where user is not found
//            throw new ChangeSetPersister.NotFoundException();
        }
    }

    public List<Reward> getUserRewards(String userId) {
        Company user = companyRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getRewards();
    }

    // Method to retrieve all available rewards
    public List<Reward> getAvailableRewards() {
        return rewardRepository.findAll();
    }

    // Method to update the details of a reward
    public void updateReward(Reward updatedReward) {
        rewardRepository.save(updatedReward);
    }

    // Method to delete a reward from the system
    public void deleteReward(String rewardId) {
        rewardRepository.deleteById(rewardId);
    }

    // Method to redeem a reward for a specific user
    public void redeemReward(String userId, Reward redeemedReward) {
        removeRewardFromUser(userId, redeemedReward);
        // Other logic for redeeming the reward (e.g., sending confirmation email)
    }

    // Method to validate whether a specific reward is valid for redemption
    public boolean validateReward(Reward reward) {
        // Example validation logic: Check if reward point requirement is less than user's points
        return reward.getPts() <= 1000; // Example threshold of 1000 points
    }

//    // Method to search for rewards based on criteria
//    public List<Reward> searchRewards(String keyword) {
//        // Example search by reward name or description
//        return rewardRepository.findByDescriptionContainingIgnoreCaseOrNameContainingIgnoreCase(keyword, keyword);
//    }
//
//    // Method to sort rewards based on criteria
//    // Example: Sort rewards by name in ascending order
//    public List<Reward> sortRewardsByNameAsc() {
//        return rewardRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
//    }
//
//    // Method to filter rewards based on criteria
//    // Example: Filter rewards by category
//    public List<Reward> filterRewardsByCategory(String category) {
//        return rewardRepository.findByCategoryIgnoreCase(category);
//    }
//
//    // Method to export reward data to a file format
//    // Example: Export rewards to CSV
//    public void exportRewardsToCSV() {
//        // Implement CSV export logic
//    }

    // Method to remove multiple rewards from a user
    private void removeRewardsFromUser(String userId, List<Reward> rewardsToRemove) {
        Query query = new Query(Criteria.where("_id").is(userId));
        Update update = new Update().pullAll("rewards", rewardsToRemove.toArray());
        mongoTemplate.updateFirst(query, update, Company.class);
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
    private void removeAllRewardsFromAllUsers() {
        Query query = new Query();
        Update update = new Update().unset("rewards");
        mongoTemplate.updateMulti(query, update, Company.class);
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
