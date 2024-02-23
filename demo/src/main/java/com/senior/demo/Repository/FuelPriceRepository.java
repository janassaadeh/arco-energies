package com.senior.demo.Repository;

import com.senior.demo.Collections.FuelPrice;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FuelPriceRepository extends MongoRepository<FuelPrice, String> {
    // Custom methods if needed
}