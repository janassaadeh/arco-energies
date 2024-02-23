package com.senior.demo.Collections;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Reward")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reward {
    @Id
    private String id;
    private String name;

    private int pts;
    private String description;




}
