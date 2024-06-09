package com.senior.demo.Service;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Shift;
import com.senior.demo.Collections.Transaction;
import com.senior.demo.Repository.ShiftRepository;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ShiftService {

    @Autowired
    private ShiftRepository shiftRepository;

    @Autowired
    private OperatorService operatorService;

    @Autowired
    private UserService userService;

    private static final String SHIFT_ID_PREFIX = "SHIFT";

    public Shift createShiftWithCustomId(LocalDateTime startTime, LocalDateTime endTime, List<Transaction> transactions, List<CashAdditionEvent> deposits, Authentication authentication) {
        double totalTransactionsAmount = transactions.stream()
                .mapToDouble(transaction -> transaction.getQuantity() * transaction.getPump().getFuel().getFuelPrice())
                .sum();
        double totalDepositsAmount = deposits.stream().mapToDouble(CashAdditionEvent::getCashAmount).sum();

        String customId = generateCustomId();

        Shift shift = new Shift(
                customId,
                startTime,
                endTime,
                totalTransactionsAmount,
                transactions,
                totalDepositsAmount,
                deposits
        );

        OperatorResponse operator = userService.getOperator(authentication);
        System.out.println(operator.getEmail());
        if (operator == null) {
            throw new RuntimeException("Operator not found");
        }
        shift.setOperator(operator);

        return shiftRepository.save(shift);
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
