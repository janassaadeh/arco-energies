package com.senior.demo.Service;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Shift;
import com.senior.demo.Collections.Transaction;
import com.senior.demo.Repository.*;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
public class ShiftService {

    @Autowired
    private ShiftRepository shiftRepository;

    @Autowired
    private OperatorService operatorService;

    @Autowired
    private TransactionService transactionService;

    @Autowired
    private AddDepositService depositService;

    @Autowired
    private UserService userService;

    @Autowired
    private TransactionRepository transactionRepository;
    @Autowired
    private CashAdditionEventRepository cashAdditionEventRepository ;

    private static final String SHIFT_ID_PREFIX = "SHIFT";

    public Shift createShiftWithCustomId(LocalDateTime startTime, LocalDateTime endTime, List<String> transactionIds, List<String> depositIds, Authentication authentication) {
        List<Transaction> transactions = transactionRepository.findAllById(transactionIds);
        List<CashAdditionEvent> deposits = cashAdditionEventRepository.findAllById(depositIds);

        // Check if all transactions were found
        if (transactions.size() != transactionIds.size()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "One or more transactions not found");
        }

        // Check if all deposits were found
        if (deposits.size() != depositIds.size()) {
            List<String> foundDepositIds = deposits.stream().map(CashAdditionEvent::getId).collect(Collectors.toList());
            List<String> notFoundDepositIds = depositIds.stream().filter(id -> !foundDepositIds.contains(id)).collect(Collectors.toList());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "One or more deposits not found: " + notFoundDepositIds);
        }

        // Calculate total transaction and deposit amounts
        double totalTransactionsAmount = transactions.stream()
                .mapToDouble(transaction -> transaction.getQuantity() * transaction.getPump().getFuel().getFuelPrice())
                .sum();
        double totalDepositsAmount = deposits.stream().mapToDouble(CashAdditionEvent::getCashAmount).sum();

        // Generate custom ID
        String customId = generateCustomId();

        // Create and save the shift
        Shift shift = new Shift(
                customId,
                startTime,
                endTime,
                totalTransactionsAmount,
                transactions,
                totalDepositsAmount,
                deposits,
                "ended"
        );

        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new RuntimeException("Operator not found");
        }
        shift.setOperator(operator);

        return shiftRepository.save(shift);
    }

    public Shift startShift(LocalDateTime startTime, Authentication authentication) {
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Operator not found");
        }

        List<Shift> operatorShifts = shiftRepository.findByOperatorId(operator.getId());
        boolean hasActiveShift = operatorShifts.stream()
                .anyMatch(shift -> "active".equals(shift.getStatus()));

        if (hasActiveShift) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Shift is already in progress");
        }

        // Generate custom ID
        String customId = generateCustomId();

        Shift shift = new Shift();
        shift.setId(customId);
        shift.setStartTime(startTime);
        shift.setOperator(operator);
        shift.setTransactions(new ArrayList<>());
        shift.setDeposits(new ArrayList<>());
        shift.setStatus("active");
        return shiftRepository.save(shift);
    }

    public Shift addTransactionToActiveShift(String transactionId, Authentication authentication) {
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Operator not found");
        }

        String operatorId = operator.getId();
        List<Shift> operatorShifts = shiftRepository.findByOperatorId(operatorId);
        Shift activeShift = operatorShifts.stream()
                .filter(shift -> "active".equals(shift.getStatus()))
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No active shift found"));

        Transaction transaction = transactionRepository.findById(transactionId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Transaction not found"));

        activeShift.getTransactions().add(transaction);

        double totalTransactionsAmount = Optional.ofNullable(activeShift.getTransactions())
                .orElseGet(Collections::emptyList)
                .stream()
                .mapToDouble(t -> t.getQuantity() * t.getPump().getFuel().getFuelPrice())
                .sum();
        activeShift.setTotalTransactionsAmount(totalTransactionsAmount);

        return shiftRepository.save(activeShift);
    }

    public Shift addDepositToActiveShift(String depositId, Authentication authentication) {
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Operator not found");
        }

        String operatorId = operator.getId();
        List<Shift> operatorShifts = shiftRepository.findByOperatorId(operatorId);
        Shift activeShift = operatorShifts.stream()
                .filter(shift -> "active".equals(shift.getStatus()))
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No active shift found"));

        CashAdditionEvent deposit = cashAdditionEventRepository.findById(depositId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Deposit not found"));

        activeShift.getDeposits().add(deposit);

        double totalDepositsAmount = Optional.ofNullable(activeShift.getDeposits())
                .orElseGet(Collections::emptyList)
                .stream()
                .mapToDouble(CashAdditionEvent::getCashAmount)
                .sum();
        activeShift.setTotalDepositsAmount(totalDepositsAmount);

        return shiftRepository.save(activeShift);
    }

    public Shift endShift(LocalDateTime endTime, Authentication authentication) {
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Operator not found");
        }

        String operatorId = operator.getId();
        System.out.println("Looking for shifts with operatorId: " + operatorId); // Debugging log

        List<Shift> operatorShifts = shiftRepository.findByOperatorId(operatorId);
        Shift currentShift = operatorShifts.stream()
                .filter(shift -> "active".equals(shift.getStatus()))
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No active shift found"));

        System.out.println("Shift found: " + currentShift);

        // Calculate total transaction amount
        double totalTransactionsAmount = Optional.ofNullable(currentShift.getTransactions())
                .orElseGet(Collections::emptyList)
                .stream()
                .mapToDouble(transaction -> transaction.getQuantity() * transaction.getPump().getFuel().getFuelPrice())
                .sum();

        // Calculate total deposit amount
        double totalDepositsAmount = Optional.ofNullable(currentShift.getDeposits())
                .orElseGet(Collections::emptyList)
                .stream()
                .mapToDouble(CashAdditionEvent::getCashAmount)
                .sum();

        // Update the shift
        currentShift.setEndTime(endTime);
        currentShift.setTotalTransactionsAmount(totalTransactionsAmount);
        currentShift.setTotalDepositsAmount(totalDepositsAmount);
        currentShift.setStatus("ended");

        return shiftRepository.save(currentShift);
    }


    public Shift getCurrentShift(Authentication authentication) {
        OperatorResponse operator = userService.getOperator(authentication);
        if (operator == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Operator not found");
        }

        String operatorId = operator.getId();

        List<Shift> operatorShifts = shiftRepository.findByOperatorId(operatorId);
        Shift currentShift = operatorShifts.stream()
                .filter(shift -> "active".equals(shift.getStatus()))
                .findFirst()
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "No active/current shift found"));

        return currentShift;
    }


    public Shift getShiftById(String id) {
        Optional<Shift> optionalShift = shiftRepository.findById(id);
        if (!optionalShift.isPresent()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Shift with id: '" + id + "' not found");
        }
        return optionalShift.get();
    }

    public List<Shift> getAllShifts() {
        return shiftRepository.findAll();
    }

    public Shift updateShift(String id, OperatorResponse operator, LocalDateTime startTime, LocalDateTime endTime, List<Transaction> transactions, List<CashAdditionEvent> deposits) {
        Shift existingShift = getShiftById(id);

        double totalTransactionsAmount = transactions.stream().mapToDouble(Transaction::getQuantity).sum();
        double totalDepositsAmount = deposits.stream().mapToDouble(CashAdditionEvent::getCashAmount).sum();

        existingShift.setOperator(operator);
        existingShift.setStartTime(startTime);
        existingShift.setEndTime(endTime);
        existingShift.setTotalTransactionsAmount(totalTransactionsAmount);
        existingShift.setTransactions(transactions);
        existingShift.setTotalDepositsAmount(totalDepositsAmount);
        existingShift.setDeposits(deposits);

        return shiftRepository.save(existingShift);
    }

    public void deleteShiftById(String id) {
        if (!shiftRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Shift with id: '" + id + "' not found");
        }
        shiftRepository.deleteById(id);
    }

    public void deleteAllShifts() {
        shiftRepository.deleteAll();
    }

    private synchronized String generateCustomId() {
        List<Shift> allShifts = shiftRepository.findAll();

        int maxId = 999;
        for (Shift shift : allShifts) {
            String id = shift.getId();
            int numericPart = Integer.parseInt(id.replace(SHIFT_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        int nextId = maxId + 1;

        return SHIFT_ID_PREFIX + nextId;
    }
}
