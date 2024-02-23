package com.senior.demo.Repository;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface AdminRepository extends MongoRepository<Admin, String> {

    Admin findByEmail(String email);
//    Admin save(Admin u);
    User findByResetToken(String resetToken);


}
