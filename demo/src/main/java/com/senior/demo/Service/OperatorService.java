package com.senior.demo.Service;

import com.senior.demo.Collections.*;
import com.senior.demo.Repository.*;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OperatorService {
    @Autowired
    private  OperatorRepository operatorRepository ;
    @Autowired
    private  MongoTemplate mongoTemplate;
    @Autowired

    private TransactionRepository transactionRepository;
    @Autowired
    private UserRepository userRepository;




    // Method to get all admins
    public List<OperatorResponse> getAllOperators() {
        List<Operator> operators = operatorRepository.findAll();
        return operators.stream()
                .map(operator ->new OperatorResponse(operator.getId(), operator.getEmail(), operator.getPhone(),operator.getName(),operator.getDob(),operator.getAddress()))
                .collect(Collectors.toList());
    }

    // Method to get an admin by ID
    public OperatorResponse getOperatorById(String id) {
        Operator operator=operatorRepository.findById(id).orElse(null);
        OperatorResponse operatorResponse=new OperatorResponse(operator.getId(), operator.getEmail(), operator.getPhone(),operator.getName(),operator.getDob(),operator.getAddress());
        return operatorResponse;
    }

    // Method to update an existing admin
    public OperatorResponse updateOperator(String id, OperatorResponse operator) {
        Optional<Operator> optionalOperator = operatorRepository.findById(id);
        if (optionalOperator.isPresent()) {
            Operator existingOperator = optionalOperator.get();
            existingOperator.setName(operator.getName());
            existingOperator.setAddress(operator.getAddress());
            existingOperator.setDob(operator.getDob());
            existingOperator.setEmail(operator.getEmail());
            existingOperator.setPhone(operator.getPhone());

            OperatorResponse exists=new OperatorResponse(existingOperator.getId(),existingOperator.getEmail(),existingOperator.getPhone(),existingOperator.getName(),
                    existingOperator.getDob(),existingOperator.getAddress());

            // Save the updated company
            existingOperator = operatorRepository.save(existingOperator);

            // Iterate over each vehicle associated with the company
            for (Transaction transaction : existingOperator.getTransactions()) {
                // Update the company information for each vehicle
                transaction.setOperator(exists);
                // Save the updated vehicle back to the repository
                transactionRepository.save(transaction);
            }

            // Convert the updated Company to CompanyResponse
            return new OperatorResponse(
                    existingOperator.getId(),
                    existingOperator.getEmail(),
                    existingOperator.getPhone(),
                    existingOperator.getName(),
                    existingOperator.getDob(),
                    existingOperator.getAddress()
            );
        } else {
            return null;
        }
    }


    // Method to delete an admin by ID
    public void deleteOperator(String id) {
        operatorRepository.deleteById(id);
        userRepository.deleteById(id);
    }
}

