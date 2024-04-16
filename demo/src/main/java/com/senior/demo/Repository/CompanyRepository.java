package com.senior.demo.Repository;

import com.senior.demo.Collections.Company;
import org.springframework.data.mongodb.repository.MongoRepository;
import com.senior.demo.Collections.User;

import java.util.List;


public interface CompanyRepository extends MongoRepository<Company, String> {

    Company findByEmail(String email);
//    Company save(Company u);
    User findByResetToken(String resetToken);


    List<Company> findByActivated(boolean b);
}
