package com.senior.demo.Collections;

import com.senior.demo.Responses.OperatorResponse;
import jakarta.persistence.Entity;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Entity
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

    public Shift(String id, LocalDateTime startTime, LocalDateTime endTime, double totalTransactionsAmount, List<Transaction> transactions, double totalDepositsAmount, List<CashAdditionEvent> deposits) {
        this.id = id;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalTransactionsAmount = totalTransactionsAmount;
        this.transactions = transactions;
        this.totalDepositsAmount = totalDepositsAmount;
        this.deposits = deposits;
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
}
