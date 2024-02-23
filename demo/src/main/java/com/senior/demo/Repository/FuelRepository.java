package com.senior.demo.Repository;

import com.senior.demo.Collections.Fuel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FuelRepository extends MongoRepository<Fuel, String> {
    Fuel findByType(String type);
}
