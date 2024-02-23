package com.senior.demo.Service;

import com.senior.demo.Collections.Admin;
import com.senior.demo.Repository.AdminRepository;
import com.senior.demo.Responses.AdminResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdminService {

    private final AdminRepository adminRepository;

    @Autowired
    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    // Method to get all admins
    public List<AdminResponse> getAllAdmins() {
        List<Admin> admins = adminRepository.findAll();
        return admins.stream()
                .map(admin -> new AdminResponse(admin.getId(), admin.getEmail(), admin.getPhone(), admin.getName(), admin.getDob()))
                .collect(Collectors.toList());
    }

    // Method to get an admin by ID
    public AdminResponse getAdminById(String id) {
        Admin admin=adminRepository.findById(id).orElse(null);
        AdminResponse adminResponse=new AdminResponse(admin.getId(), admin.getEmail(), admin.getPhone(),admin.getName(),admin.getDob());
        return adminResponse;
    }


    // Method to update an existing admin
    public Admin updateAdmin(String id, Admin admin) {
        if (adminRepository.existsById(id)) {
            admin.setId(id); // Ensure the ID is set correctly
            return adminRepository.save(admin);
        }
        return null; // Return null if admin with given ID doesn't exist
    }

    // Method to delete an admin by ID
    public void deleteAdmin(String id) {
        adminRepository.deleteById(id);
    }
}
