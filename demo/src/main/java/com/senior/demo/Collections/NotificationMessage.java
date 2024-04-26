package com.senior.demo.Collections;


import lombok.Data;
import java.util.Map;

@Data
public class NotificationMessage {

    private String receiptToken;
    private String title;
    private String body;
}
