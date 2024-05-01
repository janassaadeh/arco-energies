package com.senior.demo.Service;


import com.senior.demo.Collections.*;
import com.senior.demo.Repository.*;
import com.senior.demo.Responses.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private CompanyRepository companyRepository;
    @Autowired
    private FuelPriceRepository fuelPriceRepository ;
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
        String companyId=vehicle.getCompany().getId();
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));
        company.setPts((int) quantity);
        double total=quantity* pump.getFuel().getFuelPrice();
        company.setBalance(company.getBalance()-total);


        companyRepository.save(company);
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

    public List<Transaction> getAllCompanyTransactions(String id) {



        return transactionRepository.findAll();
    }

    public void setBalance(String companyId,Double cash){
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));
        company.setBalance(company.getBalance()-cash);
        companyRepository.save(company);
    }
    public Transaction updateTransaction(String id,String pumpId, String vehicleId, double quantity, double odometer) {

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
//        String customId = generateCustomId();
//        Transaction updatedTransaction = new Transaction(customId, quantity, odometer, date);
//        updatedTransaction.setPump(pumpResponse);
//        updatedTransaction.setVehicle(vehicleResponse);

        Transaction existingTransaction = getTransactionById(id);
        double oldQuantity = existingTransaction.getQuantity();
        double newQuantity = quantity;

        // Calculate the difference in quantity
        double quantityDifference = newQuantity - oldQuantity;

        // Update the fields of the existing transaction with the values from the updated transaction
        existingTransaction.setQuantity(quantity);
        existingTransaction.setOdometer(odometer);
        existingTransaction.setVehicle(vehicleResponse);

        // Save the updated transaction
        Transaction savedTransaction = transactionRepository.save(existingTransaction);

        // Adjust the balance
        adjustBalance(savedTransaction, quantityDifference);

        return savedTransaction;
    }

    private void adjustBalance(Transaction transaction, double quantityDifference) {
        double totalDifference = quantityDifference * transaction.getPump().getFuel().getFuelPrice();
        int ptsDiffrence=(int)quantityDifference;
        // Get the previous vehicle associated with the transaction
        VehicleResponse previousVehicle = transaction.getVehicle();
        String previousCompanyId = previousVehicle.getCompany().getId();

        // Get the current vehicle associated with the transaction
        VehicleResponse currentVehicle = transaction.getVehicle();
        String currentCompanyId = currentVehicle.getCompany().getId();

        // Adjust balance for the previous company if the vehicle has changed companies
        if (!previousCompanyId.equals(currentCompanyId)) {
            Company previousCompany = companyRepository.findById(previousCompanyId)
                    .orElseThrow(() -> new RuntimeException("Previous company not found"));
            previousCompany.setBalance(previousCompany.getBalance() + totalDifference);
            previousCompany.setPts(previousCompany.getPts()+ptsDiffrence);
            companyRepository.save(previousCompany);

            // Adjust balance for the current company
            Company currentCompany = companyRepository.findById(currentCompanyId)
                    .orElseThrow(() -> new RuntimeException("Current company not found"));
            currentCompany.setBalance(currentCompany.getBalance() - totalDifference);
            previousCompany.setPts(previousCompany.getPts()-ptsDiffrence);

            companyRepository.save(currentCompany);
        } else {
            // No change in company, adjust the balance for the current company only
            Company company = companyRepository.findById(currentCompanyId)
                    .orElseThrow(() -> new RuntimeException("Company not found"));
            company.setBalance(company.getBalance() - totalDifference);
            company.setPts(company.getPts() - ptsDiffrence);

            companyRepository.save(company);
        }
    }

    public List<Transaction> getTransactionsByCompany(String companyName) {
    // Fetch all vehicles associated with the given company name
    List<VehicleResponse> vehicles = mongoTemplate.find(
            Query.query(Criteria.where("company.name").is(companyName)),
            VehicleResponse.class
    );

    // Initialize a list to store transactions for the company
    List<Transaction> transactions = new ArrayList<>();

    // Iterate through each vehicle
    for (VehicleResponse vehicle : vehicles) {
        // Fetch transactions for the current vehicle
        List<Transaction> vehicleTransactions = mongoTemplate.find(
                Query.query(Criteria.where("vehicle.id").is(vehicle.getId())),
                Transaction.class
        );

        // Add transactions for the current vehicle to the overall list
        transactions.addAll(vehicleTransactions);
    }

    return transactions;
}
    public void deleteTransactionById(String id) {
        // Check if the transaction exists
        if (!transactionRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Transaction with id: '" + id + "' not found");
        }
        // Delete the transaction by its ID
        transactionRepository.deleteById(id);
    }

    public void deleteAllTransactions() {
        transactionRepository.deleteAll();
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
