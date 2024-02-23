package com.senior.demo.Repository;

import com.senior.demo.Collections.CashAdditionEvent;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CashAdditionEventRepository extends MongoRepository<CashAdditionEvent, String> {
    // You can define custom query methods here if needed
}
