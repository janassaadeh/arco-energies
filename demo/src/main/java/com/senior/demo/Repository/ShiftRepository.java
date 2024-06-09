package com.senior.demo.Repository;

import com.senior.demo.Collections.Shift;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ShiftRepository extends MongoRepository<Shift, String> {
}
