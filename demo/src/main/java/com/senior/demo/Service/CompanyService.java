package com.senior.demo.Service;

import com.senior.demo.Collections.CashAdditionEvent;
import com.senior.demo.Repository.CashAdditionEventRepository;
import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

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
}
