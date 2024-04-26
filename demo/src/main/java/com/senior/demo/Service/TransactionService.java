package com.senior.demo.Service;


import com.senior.demo.Collections.*;
import com.senior.demo.Repository.OperatorRepository;
import com.senior.demo.Repository.PumpRepository;
import com.senior.demo.Repository.TransactionRepository;
import com.senior.demo.Repository.VehicleRepository;
import com.senior.demo.Responses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private PumpRepository pumpRepository;

    @Autowired
    private PumpService pumpService;

    @Autowired
    private VehicleRepository vehicleRepository;

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private UserService userService;
    @Autowired
    private OperatorRepository operatorRepository;

    private static final String TRANSACTION_ID_PREFIX = "TRANSACTION";

    public Transaction addTransactionWithCustomId(String pumpId, String vehicleId, double quantity, double odometer, LocalDateTime date, Authentication authentication) {

        // Retrieve the Fuel entity by its type
        Optional<Pump> optionalPump = pumpRepository.findById(pumpId);
        if (optionalPump == null) {
            // Handle case where Fuel with given type doesn't exist
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Pump with id: '" + pumpId + "' not found");
        }
        Pump pump = optionalPump.get();
        PumpResponse pumpResponse = pumpService.getPumpResponseById(pumpId);

        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(vehicleId);
        if (!optionalVehicle.isPresent()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle with id: '" + "' not found");
        }
        Vehicle vehicle = optionalVehicle.get();
        VehicleResponse vehicleResponse = vehicleService.getVehicleResponseById(vehicleId);

        String customId = generateCustomId();
        Transaction transaction = new Transaction(customId, quantity, odometer, date);
        transaction.setPump(pumpResponse);
        transaction.setVehicle(vehicleResponse);

        OperatorResponse operator = userService.getOperator(authentication);
        System.out.println(operator.getEmail());
        if (operator == null) {
            throw new RuntimeException("Operator not found");
        }
        transaction.setOperator(operator);

        // Add the new Transaction to the list of transactions associated with the Pump
        List<Transaction> transactions = pump.getTransactions();
        transactions.add(transaction);
        pump.setTransactions(transactions);

        // Add the new Transaction to the list of transactions associated with the Vehicle
        List<Transaction> vehicleTransactions = vehicle.getTransactions();
        vehicleTransactions.add(transaction);
        vehicle.setTransactions(vehicleTransactions);

        Transaction savedTransaction = transactionRepository.save(transaction);
        Operator operator1 = operatorRepository.findById(operator.getId())
                .orElseThrow(() -> new RuntimeException("Operator not found with id: " + operator.getId()));
        operator1.addTransaction(savedTransaction);
        operatorRepository.save(operator1);
        pumpRepository.save(pump);
        vehicleRepository.save(vehicle);

        return savedTransaction;
    }

    public Transaction getTransactionById(String id) {
        Optional<Transaction> optionalTransaction = transactionRepository.findById(id);
        if (!optionalTransaction.isPresent()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Transaction with id: '" + id + "' not found");
        }
        return optionalTransaction.get();
    }

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
    }

//    public Transaction updateTransaction(String id, Transaction updatedTransaction) {
//        Transaction existingTransaction = getTransactionById(id);
//        // Update the fields of the existing transaction with the values from the updated transaction
//        existingTransaction.setQuantity(updatedTransaction.getQuantity());
//        existingTransaction.setOdometer(updatedTransaction.getOdometer());
//        existingTransaction.setDate(updatedTransaction.getDate());
//        // Save the updated transaction
//        return transactionRepository.save(existingTransaction);
//    }

    public void deleteTransactionById(String id) {
        // Check if the transaction exists
        if (!transactionRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Transaction with id: '" + id + "' not found");
        }
        // Delete the transaction by its ID
        transactionRepository.deleteById(id);
    }

    private synchronized String generateCustomId() {

        List<Transaction> allTransactions = transactionRepository.findAll();

        int maxId = 999;
        for (Transaction transaction : allTransactions) {
            String id = transaction.getId();
            int numericPart = Integer.parseInt(id.replace(TRANSACTION_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        int nextId = maxId + 1;

        return TRANSACTION_ID_PREFIX + nextId;
    }
}
