package com.senior.demo.Controllers;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Operator;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.RegistrationResponse;
import com.senior.demo.Service.AdminService;
import com.senior.demo.Service.AuthenticationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admins")
public class AdminController {

    private final AdminService adminService;
    @Autowired
    private AuthenticationService authenticationService;
    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }
    @PostMapping("/operator/register")
    public ResponseEntity<RegistrationResponse> registerOperator(
            @RequestBody Operator user
    ){
        return ResponseEntity.ok(authenticationService.registerOperator(user));
    }
    @PostMapping("/company/register")
    public ResponseEntity<RegistrationResponse> registerCompany(
            @RequestBody Company user, Authentication authentication
            ){
        return ResponseEntity.ok(authenticationService.registerCompanyByAdmin(user,authentication));
    }
    @GetMapping
    public ResponseEntity<List<AdminResponse>> getAllAdmins() {
        List<AdminResponse> admins = adminService.getAllAdmins();
        return new ResponseEntity<>(admins, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AdminResponse> getAdminById(@PathVariable("id") String id) {
        AdminResponse admin = adminService.getAdminById(id);
        if (admin != null) {
            return new ResponseEntity<>(admin, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }


    @PutMapping("/{id}")
    public ResponseEntity<Admin> updateAdmin(@PathVariable("id") String id, @RequestBody Admin admin) {
        Admin updatedAdmin = adminService.updateAdmin(id, admin);
        if (updatedAdmin != null) {
            return new ResponseEntity<>(updatedAdmin, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAdmin(@PathVariable("id") String id) {
        adminService.deleteAdmin(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
