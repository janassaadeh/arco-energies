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

    @PostMapping("/shifts")
    public Shift createShift(@RequestBody Shift newShift, Authentication authentication) {
        return shiftService.createShiftWithCustomId(
                newShift.getStartTime(),
                newShift.getEndTime(),
                newShift.getTransactions(),
                newShift.getDeposits(),
                authentication
        );
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
}
