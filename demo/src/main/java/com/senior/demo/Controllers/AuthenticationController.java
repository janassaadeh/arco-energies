package com.senior.demo.Controllers;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Operator;
import com.senior.demo.requestClasses.AuthenticationRequest;
import com.senior.demo.Responses.AuthenticationResponse;
import com.senior.demo.Service.AuthenticationService;
import com.senior.demo.Responses.RegistrationResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService service;
    @PostMapping("/admin/register")
    public ResponseEntity<RegistrationResponse> registerAdmin(
            @RequestBody Admin user
    ){
        return ResponseEntity.ok(service.registerAdmin(user));
    }
    @PostMapping("/operator/register")
    public ResponseEntity<RegistrationResponse> registerOperator(
            @RequestBody Operator user
    ){
        return ResponseEntity.ok(service.registerOperator(user));
    }
    @PostMapping("/company/register")
    public ResponseEntity<RegistrationResponse> registerCompany(
            @RequestBody Company user
            ){
        return ResponseEntity.ok(service.registerCompany(user));
    }
    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody AuthenticationRequest request
    ){
        return ResponseEntity.ok(service.authenticate(request));

    }



}
