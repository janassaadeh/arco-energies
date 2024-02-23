package com.senior.demo.Repository;


import com.senior.demo.Collections.Pump;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PumpRepository extends MongoRepository<Pump, String> {
    Optional<Pump> findById(String id);
}
