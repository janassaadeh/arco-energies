package com.senior.demo.Controllers;

import com.senior.demo.Collections.NotificationMessage;
import com.senior.demo.Service.PushNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class NotificationController {

    @Autowired
    PushNotificationService pushNotificationService;

    @PostMapping("/notifications")
    public String sendNotificationByToken(@RequestBody NotificationMessage notificationMessage){
        return pushNotificationService.sendNotificationByToken(notificationMessage);
    }


}
