package com.senior.demo.Repository;


import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Responses.CompanyResponse;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VehicleRepository extends MongoRepository<Vehicle, String>{
    List<Vehicle> findByCompany(CompanyResponse company);
}