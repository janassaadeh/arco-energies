package com.senior.demo.Service;

import com.senior.demo.Collections.*;
import com.senior.demo.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
@Service
public class ImageService {

    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private OperatorRepository operatorRepository;
    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MongoTemplate mongoTemplate;

    public void uploadImageForUser(byte[] imageData, String userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        Image image = new Image();
        image.setData(imageData);
        image.setId(generateUniqueImageId());
        imageRepository.save(image); // Save the image to get its ID

        user.setImageId(image.getId()); // Set the ID of the uploaded image for the user
        userRepository.save(user); // Update the user entity
        if(user.getRole()== Role.ADMIN){
            Admin admin = adminRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found"));
            admin.setImageId(image.getId());
            adminRepository.save(admin);
        }
        if(user.getRole()== Role.OPERATOR){
            Operator operator = operatorRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found"));
            operator.setImageId(image.getId());
            operatorRepository.save(operator);
        }     if(user.getRole()== Role.COMPANY){
            Company company = companyRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found"));
            company.setImageId(image.getId());
            companyRepository.save(company);
        }
    }

    public Image getImageById(String id) {
        return imageRepository.findById(id).orElse(null);
    }

    public String generateUniqueImageId() {
        long id = 1000; // Start from 1000
        while (imageIdExists("IMAGE"+id)) {
            id++;
        }
        return "IMAGE"+id;
    }
    private boolean imageIdExists(String id) {
        Query query = new Query(Criteria.where("id").is(id));
        return mongoTemplate.exists(query, Image.class);
    }

}
