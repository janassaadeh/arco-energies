package com.senior.demo.Responses;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AdminResponse {
    String id;
    String email; String phone; String name; String dob;String imageId;
}
