package com.senior.demo.Controllers;

import com.senior.demo.Collections.Transaction;
import com.senior.demo.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    @PostMapping("/transactions")
    public Transaction addTransaction(@RequestBody Transaction newTransaction, @RequestParam String pumpId, @RequestParam String vehicleId) {
        return transactionService.addTransactionWithCustomId(pumpId, vehicleId, newTransaction.getQuantity(), newTransaction.getOdometer(), newTransaction.getDate());
    }

    @GetMapping("/transactions/{id}")
    public Transaction getTransactionById(@PathVariable String id) {
        return transactionService.getTransactionById(id);
    }

    @GetMapping("/transactions")
    public List<Transaction> getAllTransactions() {
        return transactionService.getAllTransactions();
    }

//    @PutMapping("/transactions/{id}")
//    public Transaction updateTransaction(@PathVariable String id, @RequestBody Transaction updatedTransaction) {
//        return transactionService.updateTransaction(id, updatedTransaction);
//    }

    @DeleteMapping("/transactions/{id}")
    public void deleteTransactionById(@PathVariable String id) {
        transactionService.deleteTransactionById(id);
    }
}
