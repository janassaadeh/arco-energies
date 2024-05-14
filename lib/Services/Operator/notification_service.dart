import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Models/notification.dart';
import 'package:dio/dio.dart';

class NotificationService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<List<Notification>> getAllNotifications() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.20.59:8080/api/notifications',
      );

      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        List<Notification> notifications = [];
        for (var notificationJson in responseData) {
          if (notificationJson is Map<String, dynamic>) {
            notifications.add(Notification.fromJson(notificationJson));
          }
        }
        return notifications;
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  Future<Notification> addNotification(NotificationBody notification) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://192.168.20.59:8080/api/notifications/add',
        data: {
          'type': notification.type,
          'price': notification.price,
          'createdDate': notification.createdDate,
          'authentication': token,
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        return Notification.fromJson(responseData);
      } else {
        throw Exception('Failed to add notification');
      }
    } catch (e) {
      throw Exception('Failed to add notification: $e');
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.delete(
        'http://192.168.20.59:8080/api/notifications',
      );

      if (response.statusCode == 200) {
        print('All notifications deleted successfully');
      } else {
        throw Exception('Failed to delete notifications');
      }
    } catch (e) {
      throw Exception('Failed to delete notifications: $e');
    }
  }

  Future<Notification> getNotificationById(String id) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.20.59:8080/api/notifications/$id',
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        return Notification.fromJson(responseData);
      } else {
        throw Exception('Failed to load notification');
      }
    } catch (e) {
      throw Exception('Failed to fetch notification: $e');
    }
  }

  Future<void> deleteNotificationById(String id) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.delete(
        'http://192.168.20.59:8080/api/notifications/$id',
      );

      if (response.statusCode == 200) {
        print('Notification deleted successfully');
      } else {
        throw Exception('Failed to delete notification');
      }
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  Future<void> storeCompanyDeviceToken(String id, String deviceToken) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://192.168.20.59:8080/api/company/device-tokens/$id',
        data: {
          'deviceToken': deviceToken,
        },
      );

      if (response.statusCode == 200) {
        print('Device token stored successfully');
      } else {
        throw Exception('Failed to store device token');
      }
    } catch (e) {
      throw Exception('Failed to store device token: $e');
    }
  }

  Future<List<String>> getAllCompanyDeviceTokens() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.20.59:8080/api/company/device-tokens',
      );

      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        List<String> deviceTokens = [];
        for (var deviceToken in responseData) {
          if (deviceToken is String) {
            deviceTokens.add(deviceToken.trim());
          }
        }
        return deviceTokens;
      } else {
        throw Exception('Failed to load device tokens');
      }
    } catch (e) {
      throw Exception('Failed to fetch device tokens: $e');
    }
  }

  Future<void> storeAdminDeviceToken(String id, String deviceToken) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://192.168.20.59:8080/admins/device-tokens/$id',
        data: deviceToken,
      );

      if (response.statusCode == 200) {
        print('Device token stored successfully');
      } else {
        throw Exception('Failed to store device token');
      }
    } catch (e) {
      throw Exception('Failed to store device token: $e');
    }
  }

  Future<List<String>> getAllAdminDeviceTokens() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.20.59:8080/admins/device-tokens',
      );

      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        List<String> deviceTokens = [];
        for (var deviceToken in responseData) {
          if (deviceToken is String) {
            deviceTokens.add(deviceToken.trim());
          }
        }
        return deviceTokens;
      } else {
        throw Exception('Failed to load device tokens');
      }
    } catch (e) {
      throw Exception('Failed to fetch device tokens: $e');
    }
  }
}
