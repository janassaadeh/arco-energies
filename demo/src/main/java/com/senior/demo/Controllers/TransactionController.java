package com.senior.demo.Controllers;

import com.senior.demo.Collections.Transaction;
import com.senior.demo.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    @PostMapping("/transactions")
    public Transaction addTransaction(@RequestBody Transaction newTransaction, @RequestParam String pumpId, @RequestParam String vehicleId, Authentication authentication) {
        return transactionService.addTransactionWithCustomId(pumpId, vehicleId, newTransaction.getQuantity(), newTransaction.getOdometer(), newTransaction.getDate(),authentication);
    }

    @GetMapping("/transactions/{id}")
    public Transaction getTransactionById(@PathVariable String id) {
        return transactionService.getTransactionById(id);
    }

    @GetMapping("/transactions")
    public List<Transaction> getAllTransactions() {
        return transactionService.getAllTransactions();
    }
    @GetMapping("/transactions/company/{id}")
    public List<Transaction> getAllTransactionsForCompany(@PathVariable String id) {
        return transactionService.getAllCompanyTransactions(id);
    }
    @PutMapping("/transactions/{id}")
    public Transaction updateTransaction(@PathVariable String id,@RequestParam String pumpId, @RequestParam String vehicleId, @RequestParam double quantity, @RequestParam double odometer) {
        return transactionService.updateTransaction( id,pumpId, vehicleId, quantity, odometer);
    }

    @DeleteMapping("/transactions/{id}")
    public void deleteTransactionById(@PathVariable String id) {
        transactionService.deleteTransactionById(id);
    }

    @DeleteMapping("/transactions")
    public void deleteAllTransactions() {
        transactionService.deleteAllTransactions();
    }

}
