package com.senior.demo.Repository;

import com.senior.demo.Collections.Shift;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;

public interface ShiftRepository extends MongoRepository<Shift, String> {
    Optional<Shift> findByOperatorAndStatus(String operatorId, String status);

    List<Shift> findByOperatorId(String operatorId);
}
