package com.senior.demo.Repository;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.RedemptionEvent;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RedemptionEventRepository extends MongoRepository<RedemptionEvent, String> {

    // You can define custom query methods here if needed
}
