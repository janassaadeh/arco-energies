package com.senior.demo.Service;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CompanyService {

    private final CompanyRepository companyRepository;
    private final EmailService emailService;
    private final CashAdditionEventRepository cashAdditionEventRepository;
    private final MongoTemplate mongoTemplate;

    @Autowired
    public CompanyService(CompanyRepository companyRepository, EmailService emailService, CashAdditionEventRepository cashAdditionEventRepository, MongoTemplate mongoTemplate) {
        this.companyRepository = companyRepository;
        this.emailService = emailService;
        this.cashAdditionEventRepository = cashAdditionEventRepository;
        this.mongoTemplate = mongoTemplate;
    }


    // Method to get all admins
    public List<CompanyResponse> getAllCompanies() {
        List<Company> companies = companyRepository.findAll();
        return companies.stream()
                .map(company ->new CompanyResponse(company.getId(), company.getEmail(), company.getPhone(),company.getName(),company.getBalance(),company.getContactName(),company.getLocation()))
                .collect(Collectors.toList());
    }

    // Method to get an admin by ID
    public CompanyResponse getCompanyById(String id) {
        Company company=companyRepository.findById(id).orElse(null);
        CompanyResponse companyResponse=new CompanyResponse(company.getId(), company.getEmail(), company.getPhone(),company.getName(),company.getBalance(),company.getContactName(),company.getLocation());
        return companyResponse;
    }

    // Method to update an existing admin
    public CompanyResponse updateCompany(String id, CompanyResponse company) {
        Optional<Company> optionalCompany = companyRepository.findById(id);
        if (optionalCompany.isPresent()) {
            Company existingCompany = optionalCompany.get();
            existingCompany.setName(company.getName());
            existingCompany.setContactName(company.getContactName());
            existingCompany.setLocation(company.getLocation());
            existingCompany.setEmail(company.getEmail());
            existingCompany.setPhone(company.getPhone());

            // Save the updated company
            companyRepository.save(existingCompany);

            // Convert the updated Company to CompanyResponse
            return new CompanyResponse(
                    existingCompany.getId(),
                    existingCompany.getEmail(),
                    existingCompany.getPhone(),
                    existingCompany.getName(),

                    existingCompany.getBalance(),

                    existingCompany.getContactName(),
                    existingCompany.getLocation()
            );
        } else {
            return null; // Return null if company with given ID doesn't exist
        }
    }


    // Method to delete an admin by ID
    public void deleteCompany(String id) {
        companyRepository.deleteById(id);
    }
}

