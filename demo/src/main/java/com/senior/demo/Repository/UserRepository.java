package com.senior.demo.Repository;

import com.senior.demo.Collections.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepository extends MongoRepository<User, String> {

    User findByEmail(String email);
    User save(User u);
    User findByResetToken(String resetToken);


}
