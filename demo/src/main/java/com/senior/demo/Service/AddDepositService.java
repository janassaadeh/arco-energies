package com.senior.demo.Service;

import com.senior.demo.Collections.*;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Responses.*;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class AddDepositService {
    private final CompanyRepository companyRepository;
    private final EmailService emailService;
    private final CashAdditionEventRepository cashAdditionEventRepository;
    private final MongoTemplate mongoTemplate;
    private final CompanyService companyService;
    private final UserService userService;

    public AddDepositService(CompanyRepository companyRepository, EmailService emailService, CashAdditionEventRepository cashAdditionEventRepository, MongoTemplate mongoTemplate, CompanyService companyService, UserService userService) {
        this.companyRepository = companyRepository;
        this.emailService = emailService;
        this.cashAdditionEventRepository = cashAdditionEventRepository;
        this.mongoTemplate = mongoTemplate;
        this.companyService = companyService;
        this.userService = userService;
    }
    public CashAdditionEvent getDepositById(String id){
        CashAdditionEvent cashAdditionEvent=cashAdditionEventRepository.findById(id).orElse(null);
        return cashAdditionEvent;

    }
    public List<CashAdditionEvent> getCashAdditionEventsByCompanyId(String companyId) {
        return cashAdditionEventRepository.findByCompanyId(companyId);
    }

    // Method to get cash addition events by admin ID
    public List<CashAdditionEvent> getCashAdditionEventsByAdminId(String adminId) {
        return cashAdditionEventRepository.findByOperatorId(adminId);
    }

    public Map<String, Object> addCashAndSendEmail(String companyId, double cashAmount, String paymentMethod, Authentication authentication) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        double currentBalance = company.getBalance();
        double newBalance = currentBalance + cashAmount;
        company.setBalance(newBalance);
        companyRepository.save(company);

        OperatorResponse admin = userService.getOperator(authentication);
        if (admin == null) {
            throw new RuntimeException("Admin not found");
        }

        // Save cash addition event
        String id = generateUniqueCashId();
        CashAdditionEvent cashAdditionEvent = new CashAdditionEvent(
                id,
                companyService.getCompanyById(companyId),
                admin,
                paymentMethod,
                cashAmount,
                LocalDateTime.now()
        );
        cashAdditionEventRepository.save(cashAdditionEvent);
        sendBalanceUpdatedEmail(company);

        Map<String, Object> result = new HashMap<>();
        result.put("newBalance", newBalance);
        result.put("cashAdditionEventId", id);
        return result;
    }
    public CashAdditionEvent updateDeposit(String id, String companyId, double cashAmount, String paymentMethod) {
        // Find the existing deposit event
        CashAdditionEvent existingDeposit = getDepositById(id);

        if (existingDeposit == null) {
            throw new RuntimeException("Deposit not found with id: " + id);
        }

        // Find the original company associated with the existing deposit
        Company originalCompany=  companyRepository.findById(existingDeposit.getCompany().getId())
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Find the new company by id
        Company newCompany = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Update the original company's balance by subtracting the original cash amount
        double originalCashAmount = existingDeposit.getCashAmount();
        double originalBalance = originalCompany.getBalance();
        originalCompany.setBalance(originalBalance - originalCashAmount);
        companyRepository.save(originalCompany);

        // Update the new company's balance by adding the new cash amount
        double newBalance = newCompany.getBalance() + cashAmount;
        newCompany.setBalance(newBalance);
        companyRepository.save(newCompany);
        CompanyResponse companyResponse=

                new CompanyResponse(newCompany.getId(),newCompany.getEmail(),newCompany.getPhone(),newCompany.getName(),newCompany.getBalance(),newCompany.getContactName(), newCompany.getLocation(), newCompany.getPts(),newCompany.getImageId(),newCompany.isActivated());
        // Update the deposit event details
        existingDeposit.setCashAmount(cashAmount);
        existingDeposit.setPaymentMethod(paymentMethod);
        existingDeposit.setCompany(companyResponse);  // Update the company reference

        // Save the updated deposit event
        cashAdditionEventRepository.save(existingDeposit);

        return existingDeposit;
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
    public void deleteDepositById(String id) {
        // Check if the transaction exists
        if (!cashAdditionEventRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Deposit with id: '" + id + "' not found");
        }
        // Delete the transaction by its ID
        cashAdditionEventRepository.deleteById(id);
    }

    private void sendBalanceUpdatedEmail(Company company) {
        String emailContent = "Dear " + company.getContactName() + ",\n\n" +
                "Your balance has been updated. Your new balance is: " + company.getBalance() + ".\n\n" +
                "Regards,\nThe Finance Team";

        emailService.sendEmail(company.getEmail(), "Balance Updated", emailContent);
    }
}
