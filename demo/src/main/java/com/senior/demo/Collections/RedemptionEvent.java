package com.senior.demo.Collections;

import com.senior.demo.Responses.AdminResponse;
import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Responses.OperatorResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@Document(collection = "RedemptionEvent")
public class RedemptionEvent {
    @Id
    private String id;
    private CompanyResponse company;
    private OperatorResponse operator;
    private Reward reward;
    private int pts;
    private LocalDateTime timestamp;

}
