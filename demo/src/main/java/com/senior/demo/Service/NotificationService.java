package com.senior.demo.Service;

//import com.senior.demo.requestClasses.PushNotificationRequest;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import com.senior.demo.Collections.Notification;
import com.senior.demo.Repository.NotificationRepository;
import com.senior.demo.Responses.OperatorResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private UserService userService;

    private static final String NOTIFICATION_ID_PREFIX = "NOTIF";

    public List<Notification> getAllNotifications() {
        return notificationRepository.findAll();
    }

    public Notification addNotification(Notification notification, Authentication authentication) {
        String customId = generateCustomId();
        notification.setId(customId);

        OperatorResponse operator = userService.getOperator(authentication);
        System.out.println(operator.getEmail());
        if (operator == null) {
            throw new RuntimeException("Operator not found");
        }
        notification.setOperator(operator);

        return notificationRepository.save(notification);
    }

    public void deleteAllNotifications() {
        notificationRepository.deleteAll();
    }

    public Notification getNotificationById(String id) {
        return notificationRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Notification not found with id: " + id));
    }

    public void deleteNotificationById(String id) {
        if (notificationRepository.existsById(id)) {
            notificationRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Notification not found with id: " + id);
        }
    }

    private synchronized String generateCustomId() {
        List<Notification> allNotifications = notificationRepository.findAll();

        int maxId = 999;
        for (Notification notification : allNotifications) {
            String id = notification.getId();
            int numericPart = Integer.parseInt(id.replace(NOTIFICATION_ID_PREFIX, ""));
            if (numericPart > maxId) {
                maxId = numericPart;
            }
        }

        int nextId = maxId + 1;

        return NOTIFICATION_ID_PREFIX + nextId;
    }

}


//    private Logger logger = LoggerFactory.getLogger(NotificationService.class);
//
//    private FCMService fcmService;
//
//    public NotificationService(FCMService fcmService) {
//        this.fcmService = fcmService;
//    }
//
//
//    public void sendPushNotificationToToken(PushNotificationRequest request) {
//        try {
//            fcmService.sendMessageToToken(request);
//        } catch (Exception e) {
//            logger.error(e.getMessage());
//        }
//    }

