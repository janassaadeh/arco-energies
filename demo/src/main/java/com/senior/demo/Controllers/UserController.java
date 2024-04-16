package com.senior.demo.Controllers;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Company;
import com.senior.demo.Collections.Role;
import com.senior.demo.Collections.User;
import com.senior.demo.Collections.*;
import com.senior.demo.Repository.AdminRepository;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.OperatorRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final AdminRepository adminRepository;
    private final CompanyRepository companyRepository;
    private final OperatorRepository operatorRepository;


    @Autowired
    public UserController(UserService userService, AdminRepository adminRepository, CompanyRepository companyRepository, OperatorRepository operatorRepository) {
        this.userService = userService;
        this.adminRepository = adminRepository;
        this.companyRepository = companyRepository;
        this.operatorRepository = operatorRepository;
    }

//    @GetMapping("/company")
//    @PreAuthorize("hasAuthority('ADMIN')")
//    public List<Company> getCompanyUsers() {
//        List<User> users = userService.getCompanyUsers();
//        return users.stream()
//                .map(this::convertToCompany)
//                .collect(Collectors.toList());
//    }

    //    private Company convertToCompany(User user) {
//        Company dto = new Company();
//        dto.setId(user.getId());
//        dto.setEmail(user.getEmail());
//        dto.setPhone(user.getPhone());
//        dto.setName(user.getName());
//        dto.setBalance(user.getBalance());
//        dto.setContactName(user.getContactName());
//        dto.setLocation(user.getLocation());
//        return dto;
//    }
//    private Admin convertToAdmin(User user) {
//        Admin dto = new Admin();
//        dto.setId(user.getId());
//        dto.setEmail(user.getEmail());
//        dto.setPhone(user.getPhone());
//        dto.setName(user.getName());
//        dto.setDob(user.getDob());
//        return dto;
//    }
//    private Operator convertToOperator (User user) {
//        Operator dto = new Operator();
//        dto.setId(user.getId());
//        dto.setEmail(user.getEmail());
//        dto.setPhone(user.getPhone());
//        dto.setName(user.getName());
//        dto.setDob(user.getDob());
//        dto.setAddress(user.getAddress());
//        return dto;
//    }
//    @GetMapping("/usesr")
//    @PreAuthorize("hasAuthority('COMPANY')")
//    public Company getCompanyUser(Authentication authentication) {
//        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
//            User user= (User) authentication.getPrincipal();
//                 return convertToCompany(user);
//
//        } else {
//        }
//        return null;
//    }


    @GetMapping("/identity")
//    @PreAuthorize("hasAuthority('ADMIN')")
    public Object getAnyUser(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            User user = (User) authentication.getPrincipal();
//            return convertToAdmin(user);
            if (user.getRole() == Role.ADMIN) {
                Admin u = adminRepository.findByEmail(user.getEmail());
                AdminResponse admin = new AdminResponse(user.getId(),u.getEmail(),u.getPhone(),u.getName(),u.getDob());
                return admin;

            } else {
                if (user.getRole() == Role.COMPANY) {
//                    return companyRepository.findByEmail(user.getEmail())

                    Company u = companyRepository.findByEmail(user.getEmail());
                    CompanyResponse company = new CompanyResponse(user.getId(),u.getEmail(),u.getPhone(),u.getName(),u.getBalance(),u.getContactName(),u.getLocation(),u.getPts());
                    return company;


                } else {
                    if (user.getRole() == Role.OPERATOR) return operatorRepository.findByEmail(user.getEmail())
                            ;

//                    Operator u = operatorRepository.findByEmail(user.getEmail());
//                    OperatorResponse operator = new CompanyResponse(user.getId(),u.getEmail(),u.getPhone(),u.getName(),u.getBalance(),u.getContactName(),u.getLocation());
//                    return company;
                }
            }
        } else {
        }
        return null;
    }
}