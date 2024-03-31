package com.senior.demo.requestClasses;

import lombok.Data;

@Data
public class AddCashRequestDTO {
    private double cashAmount;

    private String companyId;
    private String paymentMethod;

}
