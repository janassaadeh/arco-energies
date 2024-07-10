package com.senior.demo.Collections;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Transaction;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Document(collection = "shifts")
public class Shift {
    @Id
    private String id;
    private OperatorResponse operator;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private double totalTransactionsAmount;
    private List<Transaction> transactions;
    private double totalDepositsAmount;
    private List<CashAdditionEvent> deposits;
    private String status; // Make sure this field is present

    // Constructor, getters, and setters

    public Shift() {}

    public Shift(String id, LocalDateTime startTime, LocalDateTime endTime, double totalTransactionsAmount, List<Transaction> transactions, double totalDepositsAmount, List<CashAdditionEvent> deposits, String status) {
        this.id = id;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalTransactionsAmount = totalTransactionsAmount;
        this.transactions = transactions;
        this.totalDepositsAmount = totalDepositsAmount;
        this.deposits = deposits;
        this.status = status; // Ensure status is included
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public OperatorResponse getOperator() {
        return operator;
    }

    public void setOperator(OperatorResponse operator) {
        this.operator = operator;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public double getTotalTransactionsAmount() {
        return totalTransactionsAmount;
    }

    public void setTotalTransactionsAmount(double totalTransactionsAmount) {
        this.totalTransactionsAmount = totalTransactionsAmount;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }

    public double getTotalDepositsAmount() {
        return totalDepositsAmount;
    }

    public void setTotalDepositsAmount(double totalDepositsAmount) {
        this.totalDepositsAmount = totalDepositsAmount;
    }

    public List<CashAdditionEvent> getDeposits() {
        return deposits;
    }

    public void setDeposits(List<CashAdditionEvent> deposits) {
        this.deposits = deposits;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
