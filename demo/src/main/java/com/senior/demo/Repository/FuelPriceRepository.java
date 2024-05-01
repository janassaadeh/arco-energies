package com.senior.demo.Repository;

import com.senior.demo.Collections.FuelPrice;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FuelPriceRepository extends MongoRepository<FuelPrice, String> {
    Optional<FuelPrice> findTopByOrderByCreatedDateDesc();

    // Custom methods if needed
}