package com.senior.demo.Repository;

import com.senior.demo.Collections.CashAdditionEvent;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CashAdditionEventRepository extends MongoRepository<CashAdditionEvent, String> {
    List<CashAdditionEvent> findByCompanyId(String companyId);
    List<CashAdditionEvent> findByOperatorId(String adminId);
    // You can define custom query methods here if needed
}
