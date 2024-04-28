package com.senior.demo.Controllers;

import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Service.CompanyService;
import com.senior.demo.Service.DiscountCalculationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/company")
public class CompanyController {

    private final CompanyService companyService;

    private final DiscountCalculationService discountCalculationService;
    @Autowired
    public CompanyController(CompanyService companyService, DiscountCalculationService discountCalculationService) {
        this.companyService = companyService;
        this.discountCalculationService = discountCalculationService;
    }
    @GetMapping("/{companyId}/transaction/discount")
    public double calculateDiscountForNextTransaction(@PathVariable String companyId) {
        // Call the DiscountCalculationService to get the discount for the company's next transaction
        return discountCalculationService.calculateDiscount(companyId);
    }

    @GetMapping("/all")
    public ResponseEntity<List<CompanyResponse>> getAllCompanies() {
        List<CompanyResponse> companies = companyService.getAllCompanies();
        return new ResponseEntity<>(companies, HttpStatus.OK);
    }

    @GetMapping("activated/all")
    public ResponseEntity<List<CompanyResponse>> getAllActivatedCompanies() {
        List<CompanyResponse> companies = companyService.getAllActivatedCompanies();
        return new ResponseEntity<>(companies, HttpStatus.OK);
    }

    @PostMapping("activate/{id}")
    public ResponseEntity<Boolean> activateCompany(@PathVariable("id") String id) {
        companyService.Activate(id);
        return new ResponseEntity<>(true, HttpStatus.OK);
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
