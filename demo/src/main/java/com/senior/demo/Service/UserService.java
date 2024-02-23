package com.senior.demo.Service;

import com.senior.demo.Collections.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import java.util.List;

@Service
public class UserService {

    private final MongoTemplate mongoTemplate;

    @Autowired
    public UserService(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public List<User> getCompanyUsers() {
        Query query = new Query();
        query.addCriteria(Criteria.where("role").is("COMPANY"));
        return mongoTemplate.find(query, User.class);
    }
    public List<User> getOperatorUsers() {
        Query query = new Query();
        query.addCriteria(Criteria.where("role").is("OPERATOR"));
        return mongoTemplate.find(query, User.class);
    }
    public List<User> getAdminUsers() {
        Query query = new Query();
        query.addCriteria(Criteria.where("role").is("ADMIN"));
        return mongoTemplate.find(query, User.class);
    }

    public String generateUniqueUserId() {
        long id = 1000; // Start from 1000
        while (userIdExists("USER"+id)) {
            id++;
        }
        return "USER"+id;
    }

    private boolean userIdExists(String id) {
        Query query = new Query(Criteria.where("id").is(id));
        return mongoTemplate.exists(query, User.class);
    }



}
