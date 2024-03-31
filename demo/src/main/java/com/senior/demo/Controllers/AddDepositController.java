package com.senior.demo.Controllers;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Responses.CashAdditionResponse;
import com.senior.demo.Responses.ErrorResponse;
import com.senior.demo.Service.AddDepositService;
import com.senior.demo.Service.CompanyService;
import com.senior.demo.requestClasses.AddCashRequestDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/deposit")

public class AddDepositController {
    @Autowired

    AddDepositService addDepositService;
    CompanyService companyService;

    @PostMapping("/addCash")
    public ResponseEntity<Object> addCashToCompany(@RequestBody AddCashRequestDTO requestDTO, Authentication authentication) {
        try {
            Map<String, Object> result = addDepositService.addCashAndSendEmail(requestDTO.getCompanyId(), requestDTO.getCashAmount(), requestDTO.getPaymentMethod(), authentication);

            double newBalance = (double) result.get("newBalance");
            String cashAdditionEventId = (String) result.get("cashAdditionEventId");

            CashAdditionResponse response = new CashAdditionResponse( cashAdditionEventId,newBalance, "Cash added successfully.");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            ErrorResponse errorResponse = new ErrorResponse("Failed to add cash and send email: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @GetMapping("/receipt/{id}")
    public ResponseEntity<Object> getReceiptById(@PathVariable String id) {
        try {
            CashAdditionEvent cashAdditionEvent = addDepositService.getDepositById(id);
            if (cashAdditionEvent != null) {
                return ResponseEntity.ok(cashAdditionEvent);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            ErrorResponse errorResponse = new ErrorResponse("Failed to retrieve receipt: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }





}
