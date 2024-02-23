package com.senior.demo.Controllers;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Company;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.requestClasses.AddCashRequestDTO;
import com.senior.demo.Responses.CashAdditionResponse;
import com.senior.demo.Responses.ErrorResponse;
import com.senior.demo.Service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @GetMapping("/all")
    public ResponseEntity<List<CompanyResponse>> getAllCompanies() {
        List<CompanyResponse> companies = companyService.getAllCompanies();
        return new ResponseEntity<>(companies, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CompanyResponse> getCompanyById(@PathVariable("id") String id) {
        CompanyResponse company = companyService.getCompanyById(id);
        if (company != null) {
            return new ResponseEntity<>(company, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }


    @PutMapping("/{id}")
    public ResponseEntity<CompanyResponse> updateCompany(@PathVariable("id") String id, @RequestBody CompanyResponse company) {
        CompanyResponse updatedCompany = companyService.updateCompany(id, company);
        if (updatedCompany != null) {
            return new ResponseEntity<>(updatedCompany, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAdmin(@PathVariable("id") String id) {
        companyService.deleteCompany(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

}
