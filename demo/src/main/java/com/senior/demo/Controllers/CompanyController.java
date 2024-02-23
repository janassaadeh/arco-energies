package com.senior.demo.Controllers;

import com.senior.demo.requestClasses.AddCashRequestDTO;
import com.senior.demo.Responses.CashAdditionResponse;
import com.senior.demo.Responses.ErrorResponse;
import com.senior.demo.Service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/company")
public class CompanyController {

    private final CompanyService companyService;

    @Autowired
    public CompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    @PostMapping("/addCash")
    public ResponseEntity<Object> addCashToCompany(@RequestBody AddCashRequestDTO requestDTO) {
      try{
        double newBalance = companyService.addCashAndSendEmail(requestDTO.getCompanyId(), requestDTO.getCashAmount());
        CashAdditionResponse response = new CashAdditionResponse(newBalance, "Cash added successfully");
        return ResponseEntity.status(HttpStatus.OK).body(response);}
      catch (Exception e){
              ErrorResponse errorResponse = new ErrorResponse("Failed to add cash and send email: " + e.getMessage());
              return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
      }
    }

}
