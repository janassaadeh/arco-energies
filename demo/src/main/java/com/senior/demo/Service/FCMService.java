//package com.senior.demo.Service;
//import java.time.Duration;
//import java.util.Map;
//import java.util.concurrent.ExecutionException;
//
//import com.senior.demo.requestClasses.PushNotificationRequest;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.stereotype.Service;
//
//import com.google.firebase.messaging.AndroidConfig;
//import com.google.firebase.messaging.AndroidNotification;
//import com.google.firebase.messaging.ApnsConfig;
//import com.google.firebase.messaging.Aps;
//import com.google.firebase.messaging.FirebaseMessaging;
//import com.google.firebase.messaging.Message;
//import com.google.firebase.messaging.Notification;
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//
//@Service
//public class FCMService {
//
//    private Logger logger = LoggerFactory.getLogger(FCMService.class);
//
//    public void sendMessageToToken(PushNotificationRequest request)
//            throws InterruptedException, ExecutionException {
//        Message message = getPreconfiguredMessageToToken(request);
//        Gson gson = new GsonBuilder().setPrettyPrinting().create();
//        String jsonOutput = gson.toJson(message);
//        String response = sendAndGetResponse(message);
//        logger.info("Sent message to token. Device token: " + request.getToken() + ", " + response + " msg " + jsonOutput);
//    }
//
//    private String sendAndGetResponse(Message message) throws InterruptedException, ExecutionException {
//        return FirebaseMessaging.getInstance().sendAsync(message).get();
//    }
//
//    private AndroidConfig getAndroidConfig(String topic) {
//        return AndroidConfig.builder()
//                .setTtl(Duration.ofMinutes(2).toMillis())
//                .setCollapseKey(topic)
//                .setPriority(AndroidConfig.Priority.HIGH)
//                .setNotification(AndroidNotification.builder()
//                        .setTag(topic)
//                        .build())
//                .build();
//    }
//
//    private ApnsConfig getApnsConfig(String topic) {
//        return ApnsConfig.builder()
//                .setAps(Aps.builder()
//                        .setCategory(topic)
//                        .setThreadId(topic)
//                        .build())
//                .build();
//    }
//
//    private Message getPreconfiguredMessageToToken(PushNotificationRequest request) {
//        AndroidConfig androidConfig = getAndroidConfig(request.getTopic());
//        ApnsConfig apnsConfig = getApnsConfig(request.getTopic());
//
//        return Message.builder()
//                .setToken(request.getToken())
//                .setApnsConfig(apnsConfig)
//                .setAndroidConfig(androidConfig)
//                .putData("title", request.getTitle())
//                .putData("message", request.getMessage())
//                .build();
//    }
//}