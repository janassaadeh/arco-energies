package com.senior.demo.Repository;

import com.senior.demo.Collections.Company;
import org.springframework.data.mongodb.repository.MongoRepository;
import com.senior.demo.Collections.User;


public interface CompanyRepository extends MongoRepository<Company, String> {

    Company findByEmail(String email);
//    Company save(Company u);
    User findByResetToken(String resetToken);


}
