package com.senior.demo.Service;


import com.senior.demo.Collections.Pump;
import com.senior.demo.Collections.Transaction;
import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Repository.PumpRepository;
import com.senior.demo.Repository.TransactionRepository;
import com.senior.demo.Repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private PumpRepository pumpRepository;

    @Autowired
    private VehicleRepository vehicleRepository;

    private static final String TRANSACTION_ID_PREFIX = "TRANSACTION";

    public Transaction addTransactionWithCustomId(String pumpId, String vehicleId, double quantity, double odometer, LocalDate date) {

        // Retrieve the Fuel entity by its type
        Optional<Pump> pump = pumpRepository.findById(pumpId);
        if (pump == null) {
            // Handle case where Fuel with given type doesn't exist
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Pump with id: '" + pumpId + "' not found");
        }

        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(vehicleId);
        if (!optionalVehicle.isPresent()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vehicle with id: '" + "' not found");
        }
        Vehicle vehicle = optionalVehicle.get();

        String customId = generateCustomId();
        Transaction transaction = new Transaction(customId, quantity, odometer, date);

        // Add the new Transaction to the list of transactions associated with the Pump
        List<Transaction> transactions = pump.get().getTransactions();
        transactions.add(transaction);
        pump.get().setTransactions(transactions);

        List<Transaction> vehicleTransactions = vehicle.getTransactions();
        vehicleTransactions.add(transaction);
        vehicle.setTransactions(vehicleTransactions);

        Transaction savedTransaction = transactionRepository.save(transaction);

        pumpRepository.save(pump.get());
        vehicleRepository.save(vehicle);

        return savedTransaction;
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
