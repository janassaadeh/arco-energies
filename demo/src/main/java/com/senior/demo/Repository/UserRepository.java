package com.senior.demo.Repository;

import com.senior.demo.Collections.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;


public interface UserRepository extends MongoRepository<User, String> {

    User findByEmail(String email);
    User save(User u);
    User findByResetToken(String resetToken);
    User findByImageId(String imageId);


}
