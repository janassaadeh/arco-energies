package com.senior.demo.Controllers;

import com.senior.demo.Collections.Shift;
import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Transaction;
import com.senior.demo.Responses.OperatorResponse;
import com.senior.demo.Service.ShiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ShiftController {

    @Autowired
    private ShiftService shiftService;

//    @PostMapping("/shifts")
//    public Shift createShift(@RequestBody ShiftRequest shiftRequest, Authentication authentication) {
//        return shiftService.createShiftWithCustomId(
//                shiftRequest.getStartTime(),
//                shiftRequest.getEndTime(),
//                shiftRequest.getTransactionIds(),
//                shiftRequest.getDepositIds(),
//                authentication
//        );
//    }

    @PostMapping("/shifts/start")
    public Shift startShift(@RequestBody ShiftRequest shiftRequest, Authentication authentication) {
        return shiftService.startShift(shiftRequest.getStartTime(), authentication);
    }

    @PostMapping("/shifts/add-transaction")
    public Shift addTransactionToActiveShift(@RequestBody AddTransactionRequest request, Authentication authentication) {
        return shiftService.addTransactionToActiveShift(request.getTransactionId(), authentication);
    }

    @PostMapping("/shifts/add-deposit")
    public Shift addDepositToActiveShift(@RequestBody AddDepositRequest request, Authentication authentication) {
        return shiftService.addDepositToActiveShift(request.getDepositId(), authentication);
    }

    @PostMapping("/shifts/end")
    public Shift endShift(
            @RequestBody ShiftRequest shiftRequest,
            Authentication authentication
    ) {
        return shiftService.endShift(
                shiftRequest.getEndTime(),
                authentication
        );
    }

    @GetMapping("/shifts/current")
    public Shift getCurrentShift(Authentication authentication) {
        return shiftService.getCurrentShift(authentication);
    }

    @GetMapping("/shifts/{id}")
    public Shift getShiftById(@PathVariable String id) {
        return shiftService.getShiftById(id);
    }

    @GetMapping("/shifts")
    public List<Shift> getAllShifts() {
        return shiftService.getAllShifts();
    }

    @PutMapping("/shifts/{id}")
    public Shift updateShift(@PathVariable String id, @RequestBody Shift updatedShift) {
        return shiftService.updateShift(id, updatedShift.getOperator(), updatedShift.getStartTime(), updatedShift.getEndTime(), updatedShift.getTransactions(), updatedShift.getDeposits());
    }

    @DeleteMapping("/shifts/{id}")
    public void deleteShiftById(@PathVariable String id) {
        shiftService.deleteShiftById(id);
    }

    @DeleteMapping("/shifts")
    public void deleteAllShifts() {
        shiftService.deleteAllShifts();
    }

    public static class ShiftRequest {
        private LocalDateTime startTime;
        private LocalDateTime endTime;

        // Getters and setters
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
    }

    public static class AddTransactionRequest {
        private String transactionId;

        public String getTransactionId() {
            return transactionId;
        }

        public void setTransactionId(String transactionId) {
            this.transactionId = transactionId;
        }
    }

    public static class AddDepositRequest {
        private String depositId;

        public String getDepositId() {
            return depositId;
        }

        public void setDepositId(String depositId) {
            this.depositId = depositId;
        }
    }
}

