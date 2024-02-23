package com.senior.demo.email;

import com.senior.demo.Service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/send-email")
    public String sendEmail(@RequestParam("to") String to, @RequestParam("subject") String subject, @RequestParam("body") String body) {
        emailService.sendEmail(to, subject, body);
        return "Email sent successfully!";
    }
}
