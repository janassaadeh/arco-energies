package com.senior.demo.Controllers;

import com.senior.demo.Collections.Notification;
import com.senior.demo.Collections.NotificationMessage;
import com.senior.demo.Service.NotificationService;
import com.senior.demo.Service.PushNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class NotificationController {

    @Autowired
    PushNotificationService pushNotificationService;

    @Autowired
    NotificationService notificationService;

    @PostMapping("/notifications/push")
    public String sendNotificationByToken(@RequestBody NotificationMessage notificationMessage){
        return pushNotificationService.sendNotificationByToken(notificationMessage);
    }

    @GetMapping("/notifications")
    public List<Notification> getAllNotifications() {
        return notificationService.getAllNotifications();
    }

    @PostMapping("/notifications/add")
    public Notification addNotification(@RequestBody Notification notification) {
        return notificationService.addNotification(notification);
    }

    @DeleteMapping("/notifications/{id}")
    public String deleteNotificationById(@PathVariable String id) {
        notificationService.deleteNotificationById(id);
        return "Notification deleted successfully";
    }

    @DeleteMapping("/notifications")
    public String deleteAllNotifications() {
        notificationService.deleteAllNotifications();
        return "All notifications deleted successfully";
    }
}
