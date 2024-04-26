//package com.senior.demo.Controllers;
//import com.senior.demo.Responses.PushNotificationResponse;
//import com.senior.demo.Service.NotificationService;
//import com.senior.demo.requestClasses.PushNotificationRequest;
//import org.springframework.http.HttpStatus;
//
//
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class PushNotificationController {
//
//
//    private NotificationService pushNotificationService;
//
//    public PushNotificationController(NotificationService pushNotificationService) {
//        this.pushNotificationService = pushNotificationService;
//    }
//
//    @PostMapping("/api/v1/auth/notification/token")
//    public ResponseEntity sendTokenNotification(@RequestBody PushNotificationRequest request) {
//        pushNotificationService.sendPushNotificationToToken(request);
//        System.out.println("princr");
//        return new ResponseEntity<>(new PushNotificationResponse(HttpStatus.OK.value(), "Notification has been sent."), HttpStatus.OK);
//    }
//
//}