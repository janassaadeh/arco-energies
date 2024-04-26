package com.senior.demo.Controllers;

import com.senior.demo.Collections.Image;
import com.senior.demo.Service.ImageService;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Base64;
@Data
class Base64ImageRequest {
    private String base64Image;
}
@RestController
@RequestMapping("/images")
public class ImageController {

    @Autowired
    private ImageService imageService;

    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestBody Base64ImageRequest request, @RequestParam String userId) {
        try {
            imageService.uploadImageForUser(Base64.getDecoder().decode(request.getBase64Image()),userId);
            return ResponseEntity.status(HttpStatus.CREATED).body("Image uploaded successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to upload image: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<byte[]> getImage(@PathVariable String id) {
        Image image = imageService.getImageById(id);
        if (image != null) {
            return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image.getData());
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}


