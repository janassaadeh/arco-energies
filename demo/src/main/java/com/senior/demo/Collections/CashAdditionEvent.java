package com.senior.demo.Collections;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@Document(collection = "CashAdditionEvents")
public class CashAdditionEvent {
    @Id
    private String id;
    private String companyId;
//    private String adminId;

    private double cashAmount;
    private LocalDateTime timestamp;



    // Getters and setters
}
