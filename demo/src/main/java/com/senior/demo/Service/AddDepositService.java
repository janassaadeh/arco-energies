package com.senior.demo.Service;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Responses.AdminResponse;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        return cashAdditionEventRepository.findByAdminId(adminId);
    }

    public Map<String, Object> addCashAndSendEmail(String companyId, double cashAmount, String paymentMethod, Authentication authentication) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        double currentBalance = company.getBalance();
        double newBalance = currentBalance + cashAmount;
        company.setBalance(newBalance);
        companyRepository.save(company);

        AdminResponse admin = userService.getAdmin(authentication);
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
}
