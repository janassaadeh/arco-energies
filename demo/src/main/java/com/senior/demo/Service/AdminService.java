package com.senior.demo.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.senior.demo.Collections.Admin;
import com.senior.demo.Collections.Company;
import com.senior.demo.Repository.AdminRepository;
import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.DeviceTokensResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
                .map(admin -> new AdminResponse(admin.getId(), admin.getEmail(), admin.getPhone(), admin.getName(), admin.getDob(),admin.getImageId()))
                .collect(Collectors.toList());
    }

    // Method to get an admin by ID
    public AdminResponse getAdminById(String id) {
        Admin admin=adminRepository.findById(id).orElse(null);
        AdminResponse adminResponse=new AdminResponse(admin.getId(), admin.getEmail(), admin.getPhone(),admin.getName(),admin.getDob(),admin.getImageId());
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

    public void storeDeviceToken(String adminId, String deviceToken) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));

        List<String> deviceTokens = admin.getDeviceTokens();
        if (deviceTokens == null) {
            deviceTokens = new ArrayList<>();
        }

        if (!deviceTokens.contains(deviceToken)) {
            deviceTokens.add(deviceToken);

            admin.setDeviceTokens(deviceTokens);
            adminRepository.save(admin);
        } else {
            System.out.println("Device token already exists for admin: " + adminId);
        }
    }

    public List<DeviceTokensResponse> getAllAdminDeviceTokens() {
        List<DeviceTokensResponse> allAdminDeviceTokens = new ArrayList<>();

        List<Admin> admins = adminRepository.findAll();

        for (Admin admin : admins) {
            List<String> deviceTokens = admin.getDeviceTokens();
            DeviceTokensResponse adminResponse = new DeviceTokensResponse(admin.getId(), deviceTokens);
            allAdminDeviceTokens.add(adminResponse);
        }

        return allAdminDeviceTokens;
    }

    public void removeAllDeviceTokens(String adminId) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));

        admin.setDeviceTokens(new ArrayList<>());
        adminRepository.save(admin);
    }
}
