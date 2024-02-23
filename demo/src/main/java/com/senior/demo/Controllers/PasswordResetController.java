package com.senior.demo.Controllers;

import com.senior.demo.Service.PasswordResetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth/reset-password")
public class PasswordResetController {

    @Autowired
    private PasswordResetService passwordResetService;

    @PostMapping("/initiate")
    public ResponseEntity<String> initiatePasswordReset(@RequestParam("email") String email) {
        boolean emailSent = passwordResetService.initiatePasswordReset(email);
        if (emailSent) {
            return ResponseEntity.ok("Reset email sent!");
        } else {
            return ResponseEntity.badRequest().body("Email not found");
        }
    }


    @PostMapping("/confirm")
    public ResponseEntity<?> resetPassword(@RequestParam String token, @RequestParam String newPassword) {
        passwordResetService.resetPassword(token, newPassword);
        return ResponseEntity.ok().build();
    }

    @PostMapping ("/validate-token")
    public ResponseEntity<Boolean> isTokenValidForEmail(@RequestParam String token, @RequestParam String email) {
        boolean isValid = passwordResetService.isTokenValidForEmail(token, email);
        return ResponseEntity.ok(isValid);
    }
}
