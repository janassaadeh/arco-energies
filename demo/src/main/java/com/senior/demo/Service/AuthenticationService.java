package com.senior.demo.Service;

import com.senior.demo.Collections.*;
import com.senior.demo.Repository.UserRepository;
import com.senior.demo.auth.AuthenticationFacade;
import com.senior.demo.requestClasses.AuthenticationRequest;
import com.senior.demo.Responses.AuthenticationResponse;
import com.senior.demo.Responses.RegistrationResponse;
import com.senior.demo.config.JwtService;
import com.senior.demo.Repository.AdminRepository;
import com.senior.demo.Repository.CompanyRepository;
import com.senior.demo.Repository.OperatorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseStatus;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserRepository userRepository;
    private final AdminRepository adminRepository;
    private final CompanyRepository companyRepository;
    private final OperatorRepository operatorRepository;

    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final AuthenticationFacade authenticationFacade;
    private final UserService userService;

public RegistrationResponse registerAdmin(Admin u) {
    // Check if the user already exists
    if (userRepository.findByEmail(u.getEmail()) != null) {
        // User already exists, handle this case by throwing an exception
        throw new ForbiddenException("User with this email already exists");
    }

    // User doesn't exist, proceed with registration
    String id=userService.generateUniqueUserId();
    var user = User.builder()
            .id(id)

            .phone(u.getPhone())
            .email(u.getEmail())
            .name(u.getName())
            .password(passwordEncoder.encode(u.getPassword()))
            .role(Role.ADMIN)
            .build();

    userRepository.save(user);

    // Save the admin
    Admin admin = new Admin.Builder()
            .id(id)

            .phone(u.getPhone())
            .email(u.getEmail())
            .name(u.getName())
            .dob(u.getDob())
            .password(passwordEncoder.encode(u.getPassword()))
            .role(Role.ADMIN)
            .build();

    adminRepository.save(admin);

    // Generate JWT token
    var jwtToken = jwtService.generateToken(user);

    // Return AuthenticationResponse with token
    return RegistrationResponse.builder()
            .token(jwtToken)
            .message("Admin "+u.getName()+" registered successfully !")
            .build();
}
    public RegistrationResponse registerCompany(Company u) {
        // Check if the user already exists
        if (userRepository.findByEmail(u.getEmail()) != null) {
            // User already exists, handle this case by throwing an exception
            throw new ForbiddenException("User with this email already exists");
        }
        String id=userService.generateUniqueUserId();
        // User doesn't exist, proceed with registration
        var user = User.builder()
                .id(id)

                .phone(u.getPhone())
                .email(u.getEmail())
                .name(u.getName())
                .password(passwordEncoder.encode(u.getPassword()))
                .role(Role.COMPANY)
                .build();

        userRepository.save(user);

        Company company = new Company.Builder()
                .id(id)

                .phone(u.getPhone())
                .email(u.getEmail())
                .name(u.getName())
                .password(passwordEncoder.encode(u.getPassword()))
                .role(Role.COMPANY)
                .balance(u.getBalance())
                .contactName(u.getContactName())
                .location(u.getLocation())

                .build();
        companyRepository.save(company);

        // Generate JWT token
        var jwtToken = jwtService.generateToken(user);

        // Return AuthenticationResponse with token
        return RegistrationResponse.builder()
                .token(jwtToken)
                .message("Company "+u.getName()+" registered successfully !")

                .build();
    }
    public RegistrationResponse registerOperator(Operator u) {
        // Check if the user already exists
        if (userRepository.findByEmail(u.getEmail()) != null) {
            // User already exists, handle this case by throwing an exception
            throw new ForbiddenException("User with this email already exists");
        }
String id=userService.generateUniqueUserId();
        // User doesn't exist, proceed with registration
        var user = User.builder()
                .id(id)
                .phone(u.getPhone())
                .email(u.getEmail())
                .name(u.getName())
                .password(passwordEncoder.encode(u.getPassword()))
                .role(Role.OPERATOR)
                .build();

        userRepository.save(user);

        Operator operator = new Operator.Builders()
                .id(id)
                .phone(u.getPhone())
                .email(u.getEmail())
                .name(u.getName())
                .password(passwordEncoder.encode(u.getPassword()))
                .role(Role.OPERATOR)
                .dob(u.getDob())
                .address(u.getAddress())



                .build();
        operatorRepository.save(operator);

        // Generate JWT token
        var jwtToken = jwtService.generateToken(user);

        // Return AuthenticationResponse with token
        return RegistrationResponse.builder()
                .token(jwtToken)
                .message("Operator "+u.getName()+" registered successfully !")
                .build();
    }
    // Custom ForbiddenException class
    @ResponseStatus(HttpStatus.FORBIDDEN)
    class ForbiddenException extends RuntimeException {
        public ForbiddenException(String message) {
            super(message);
        }
    }
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
        var userOptional = userRepository.findByEmail(request.getEmail());
        var user = userRepository.findByEmail(request.getEmail());
        if (user == null) {
            throw   new UsernameNotFoundException("User not found with email: " + request.getEmail());
        }

        var jwtToken=jwtService.generateToken((UserDetails) user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .role(user.getRole().toString())
                .build();
    }

}
