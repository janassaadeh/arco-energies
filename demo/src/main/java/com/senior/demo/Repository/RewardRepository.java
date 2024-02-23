package com.senior.demo.Repository;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Reward;
import com.senior.demo.Collections.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface RewardRepository extends MongoRepository<Reward, String> {


}
