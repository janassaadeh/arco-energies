package com.senior.demo.Service;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Vehicle;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.UserRepository;
import com.senior.demo.Repository.VehicleRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CompanyService {

    private final CompanyRepository companyRepository;
    private final EmailService emailService;
    private final CashAdditionEventRepository cashAdditionEventRepository;
    private final MongoTemplate mongoTemplate;

    private final VehicleRepository vehicleRepository;
    private final UserRepository userRepository;

    @Autowired
    public CompanyService(CompanyRepository companyRepository, EmailService emailService, CashAdditionEventRepository cashAdditionEventRepository, MongoTemplate mongoTemplate, VehicleRepository vehicleRepository, UserRepository userRepository) {
        this.companyRepository = companyRepository;
        this.emailService = emailService;
        this.cashAdditionEventRepository = cashAdditionEventRepository;
        this.mongoTemplate = mongoTemplate;
        this.vehicleRepository = vehicleRepository;
        this.userRepository = userRepository;
    }

    public double addCashAndSendEmail(String companyId, double cashAmount) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        double currentBalance = company.getBalance();
        double newBalance = currentBalance + cashAmount;
        company.setBalance(newBalance);
        companyRepository.save(company);
// Save cash addition event

//        CashAdditionEvent cashAdditionEvent = new CashAdditionEvent(companyId, cashAmount, LocalDateTime.now());
//        cashAdditionEvent.setId(generateUniqueCashId());
//        cashAdditionEventRepository.save(cashAdditionEvent);
        sendBalanceUpdatedEmail(company);

        return newBalance;
    }
    public String generateUniqueCashId() {
        long id = 1000; // Start from 1000
        while (cashIdExists("CASH"+id)) {
            id++;
        }
        return "CASH"+id;
    }
    private boolean cashIdExists(String id) {
        Query query = new Query(Criteria.where("id").is(id));
        return mongoTemplate.exists(query, CashAdditionEvent.class);
    }


    private void sendBalanceUpdatedEmail(Company company) {
        String emailContent = "Dear " + company.getContactName() + ",\n\n" +
                "Your balance has been updated. Your new balance is: " + company.getBalance() + ".\n\n" +
                "Regards,\nThe Finance Team";

        emailService.sendEmail(company.getEmail(), "Balance Updated", emailContent);
    }


    // Method to get all admins
    public List<CompanyResponse> getAllCompanies() {
        List<Company> companies = companyRepository.findAll();
        return companies.stream()
                .map(company ->new CompanyResponse(company.getId(), company.getEmail(), company.getPhone(),company.getName(),company.getBalance(),company.getContactName(),company.getLocation(),
                company.getPts()

                ))
                .collect(Collectors.toList());
    }
    public List<CompanyResponse> getAllActivatedCompanies() {
        List<Company> companies = companyRepository.findByActivated(true);
        return companies.stream()
                .map(company -> new CompanyResponse(
                        company.getId(),
                        company.getEmail(),
                        company.getPhone(),
                        company.getName(),
                        company.getBalance(),
                        company.getContactName(),
                        company.getLocation(),
                        company.getPts()
                ))
                .collect(Collectors.toList());
    }


    // Method to get an admin by ID
    public CompanyResponse getCompanyById(String id) {
        Company company=companyRepository.findById(id).orElse(null);
        CompanyResponse companyResponse=new CompanyResponse(company.getId(), company.getEmail(), company.getPhone(),company.getName(),company.getBalance(),company.getContactName(),company.getLocation(),
                company.getPts()

        );
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
            existingCompany.setPts(company.getPts());


            CompanyResponse exists=new CompanyResponse(existingCompany.getId(),existingCompany.getEmail(),existingCompany.getPhone(),existingCompany.getName(),
                    existingCompany.getBalance(),existingCompany.getContactName(),existingCompany.getLocation(),
                    company.getPts()

            );

            // Save the updated company
            existingCompany = companyRepository.save(existingCompany);

            // Iterate over each vehicle associated with the company
            for (Vehicle vehicle : existingCompany.getVehicles()) {
                // Update the company information for each vehicle
                vehicle.setCompany(exists);
                // Save the updated vehicle back to the repository
                vehicleRepository.save(vehicle);
            }

            // Convert the updated Company to CompanyResponse
            return new CompanyResponse(
                    existingCompany.getId(),
                    existingCompany.getEmail(),
                    existingCompany.getPhone(),
                    existingCompany.getName(),
                    existingCompany.getBalance(),
                    existingCompany.getContactName(),
                    existingCompany.getLocation(),
                    existingCompany.getPts()


            );
        } else {
            return null; // Return null if company with given ID doesn't exist
        }
    }


    // Method to delete an admin by ID
    public void deleteCompany(String id) {
        companyRepository.deleteById(id);
        userRepository.deleteById(id);
    }
}

