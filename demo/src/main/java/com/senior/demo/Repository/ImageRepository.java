package com.senior.demo.Repository;

import com.senior.demo.Collections.Image;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ImageRepository extends MongoRepository<Image, String> {
}
