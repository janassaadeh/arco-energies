package com.senior.demo.Controllers;


import com.senior.demo.Collections.Transaction;
import com.senior.demo.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/custom_api")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    @PostMapping("/transactions")
    public Transaction addTransaction(@RequestBody Transaction newTransaction, @RequestParam String pumpId, @RequestParam String vehicleId) {
        return transactionService.addTransactionWithCustomId(pumpId, vehicleId, newTransaction.getQuantity(), newTransaction.getOdometer(), newTransaction.getDate());
    }
}
