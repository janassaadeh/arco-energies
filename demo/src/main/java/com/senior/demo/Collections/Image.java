package com.senior.demo.Collections;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Data
@Document
public class Image {
    @Id
    private String id;
    private byte[] data;

    // Getters and setters
}
