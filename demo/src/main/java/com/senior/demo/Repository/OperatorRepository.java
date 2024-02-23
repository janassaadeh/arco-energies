package com.senior.demo.Repository;

import com.senior.demo.Collections.Operator;
import com.senior.demo.Collections.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface OperatorRepository extends MongoRepository<Operator, String> {

    Operator findByEmail(String email);
    Operator save(Operator u);
    User findByResetToken(String resetToken);


}
