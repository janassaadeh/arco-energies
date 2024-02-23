package com.senior.demo.Service;

import com.senior.demo.Service.EmailService;
import com.senior.demo.Collections.User;
import com.senior.demo.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class PasswordResetService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;
    public boolean isTokenValidForEmail(String token, String email) {
        System.out.println("Email: " + email); // Log the email
        System.out.println("Token: " + token); // Log the token

        // Your existing code...

        User user = userRepository.findByEmail(email);
        System.out.println("User: " + user); // Log the user

        if (user == null || user.getResetToken() == null) {
            System.out.println("User or Reset Token is null"); // Log if user or reset token is null
            return false; // Handle null user or null reset token gracefully
        }

        boolean isValid = user.getResetToken().equals(token);
        System.out.println("Is Token Valid: " + isValid); // Log if token is valid or not
        return isValid;
    }



    public boolean initiatePasswordReset(String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String resetToken = generateRandomToken();
            user.setResetToken(resetToken);
            userRepository.save(user);

            // Send email with reset link
            String resetLink = resetToken;
            String emailContent = "Reset your password using this code: " + resetLink;
            emailService.sendEmail(email, "Password Reset", emailContent);

            return true; // Indicate that reset email was sent
        } else {
            // Handle invalid email
            return false; // Indicate that email was not found
        }
    }

    private String generateRandomToken() {
        Random random = new Random();
        int min = 1000; // minimum 4-digit number
        int max = 9999; // maximum 4-digit number
        int randomInt = random.nextInt(max - min + 1) + min;
        return String.valueOf(randomInt);
    }
    public void resetPassword(String token, String newPassword) {
        User user = userRepository.findByResetToken(token);
        if (user != null) {
            user.setPassword(passwordEncoder.encode(newPassword));
            user.setResetToken(null); // Reset token after password change
            userRepository.save(user);
        } else {
            // Handle invalid or expired token
        }
    }
    public boolean isTokenValid(String token) {
        User user = userRepository.findByResetToken(token);
        return user != null;
    }



}
