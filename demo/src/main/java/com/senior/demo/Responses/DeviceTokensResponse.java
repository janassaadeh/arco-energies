package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class DeviceTokensResponse {
    private String id;
    private List<String> deviceTokens;
}
