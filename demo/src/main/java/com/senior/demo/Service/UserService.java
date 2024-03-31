package com.senior.demo.Service;

import com.senior.demo.Collections.*;
import com.senior.demo.Repository.AdminRepository;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.OperatorRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import java.util.List;

@Service
public class UserService {

    private final MongoTemplate mongoTemplate;
    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private OperatorRepository operatorRepository;

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

    public Object getUserDetails(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof User) {
            User user = (User) authentication.getPrincipal();
            if (user.getAuthorities().contains(Role.ADMIN)) {
                Admin admin = adminRepository.findByEmail(user.getUsername());
                return new AdminResponse(user.getId(), admin.getEmail(), admin.getPhone(), admin.getName(), admin.getDob());
            } else if (user.getAuthorities().contains(Role.COMPANY)) {
                Company company = companyRepository.findByEmail(user.getUsername());
                return new CompanyResponse(user.getId(), company.getEmail(), company.getPhone(), company.getName(), company.getBalance(), company.getContactName(), company.getLocation());
            } else if (user.getAuthorities().contains(Role.OPERATOR)) {
                Operator operator = operatorRepository.findByEmail(user.getUsername());
//                return new OperatorResponse(user.getId(), operator.getEmail(), operator.getPhone(), operator.getName());
            }
        }
        return null;
    }
    public AdminResponse getAdmin(Authentication authentication) {
//        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof User)
        User user = (User) authentication.getPrincipal();

        Admin admin = adminRepository.findByEmail(user.getUsername());
        return new AdminResponse(user.getId(), admin.getEmail(), admin.getPhone(), admin.getName(), admin.getDob());



    }


}
