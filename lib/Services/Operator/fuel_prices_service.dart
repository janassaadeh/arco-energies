import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Models/notification.dart' as not;

class FuelPricesService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<List<FuelPrice>> getFuelPrices() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://arcoenergies.onrender.com/api/fuel_prices',
      );

      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        List<FuelPrice> fuelPrices = [];
        for (var fuelPriceJson in responseData) {
          if (fuelPriceJson is Map<String, dynamic>) {
            fuelPrices.add(FuelPrice.fromJson(fuelPriceJson));
          }
        }
        return fuelPrices;
      } else {
        throw Exception('Failed to load fuel prices');
      }
    } catch (e) {
      throw Exception('Failed to fetch fuel prices: $e');
    }
  }

  Future<void> addFuelPrice(
      String fuelType, double price, DateTime createdDate) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'https://arcoenergies.onrender.com/api/fuel_prices',
        queryParameters: {
          'fuelType': fuelType,
        },
        data: {
          'price': price,
          'createdDate': createdDate.toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        print('Fuel price added successfully');
      } else {
        throw Exception('Failed to add fuel price');
      }
    } catch (e) {
      throw Exception('Failed to add fuel price: $e');
    }
  }

  Future<void> addFuelPrices(List<FuelPrice> fuelPrices) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      if (token == null) {
        throw Exception('Token is null');
      }
      print('Token: $token'); // Debugging line
      dio.options.headers['Authorization'] = 'Bearer $token';

      for (FuelPrice fuelPrice in fuelPrices) {
        final response = await dio.post(
          'https://arcoenergies.onrender.com/api/fuel_prices',
          queryParameters: {
            'fuelType': fuelPrice.fuelResponse?.type,
          },
          data: {
            'price': fuelPrice.price,
            'createdDate': fuelPrice.createdDate,
          },
        );

        if (response.statusCode != 200) {
          throw Exception(
              'Failed to add fuel price for ${fuelPrice.fuelResponse?.type} with status code: ${response.statusCode}');
        }
      }
      print('All fuel prices added successfully');
    } catch (e) {
      print('Failed to add fuel prices: $e');
      throw Exception('Failed to add fuel prices: $e');
    }
  }

  Future<void> sendAdminPushNotifications(List<FuelPrice> fuelPrices) async {
    try {
      final List<String> allDeviceTokens = await getAllAdDeviceTokens();

      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      String fuelPricesDetails = '';
      for (var fuelPrice in fuelPrices) {
        fuelPricesDetails +=
            '${fuelPrice.fuelResponse!.type}: ${fuelPrice.price.toStringAsFixed(2)}, ';
      }
      fuelPricesDetails =
          fuelPricesDetails.trim().replaceAll(RegExp(r',\s*$'), '');

      final notificationMessage = {
        'title': 'New Fuel Prices List',
        'body': 'Fuel prices details: $fuelPricesDetails',
      };

      for (var deviceToken in allDeviceTokens) {
        notificationMessage['receiptToken'] = deviceToken;
        final response = await dio.post(
          'https://arcoenergies.onrender.com/api/notifications/push',
          data: notificationMessage,
        );

        if (response.statusCode == 200) {
          print(
              'Push notification sent successfully to device token: $deviceToken');
        } else {
          print(
              'Failed to send push notification to device token: $deviceToken');
        }
      }
    } catch (e) {
      throw Exception('Failed to send push notifications: $e');
    }
  }

  Future<void> pushOperatorApprovedNotification(
      not.Notification notification) async {
    try {

      final deviceTokens =
          // notification.operator.deviceTokens;
          await getOperatorDeviceTokensById(notification.operator.id);

      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final notificationMessage = {
        'title': 'Fuel Price Approved',
        'body': '${notification.type}: ${notification.price} accepted',
      };

      for (var deviceToken in deviceTokens) {
        notificationMessage['receiptToken'] = deviceToken;
        final response = await dio.post(
          'https://arcoenergies.onrender.com/api/notifications/push',
          data: notificationMessage,
        );

        if (response.statusCode == 200) {
          print(
              'Push notification sent successfully to device token: $deviceToken');
        } else {
          print(
              'Failed to send push notification to device token: $deviceToken');
        }
      }
    } catch (e) {
      throw Exception('Failed to send push notification: $e');
    }
  }

  Future<void> pushOperatorDeclinedNotification(
      not.Notification notification) async {
    try {

      // final deviceTokens = notification.operator.deviceTokens;
      final deviceTokens =
          await getOperatorDeviceTokensById(notification.operator.id);

      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      print("dec");

      print(deviceTokens);

      final notificationMessage = {
        'title': 'Fuel Price Declined',
        'body': '${notification.type}: ${notification.price} declined',
      };

      for (var deviceToken in deviceTokens) {
        notificationMessage['receiptToken'] = deviceToken;
        final response = await dio.post(
          'https://arcoenergies.onrender.com/api/notifications/push',
          data: notificationMessage,
        );

        if (response.statusCode == 200) {
          print(
              'Push notification sent successfully to device token: $deviceToken');
        } else {
          print(
              'Failed to send push notification to device token: $deviceToken');
        }
      }
    } catch (e) {
      throw Exception('Failed to send push notification: $e');
    }
  }

  Future<List<String>> getAllAdDeviceTokens() async {
    try {
      final adminDeviceTokens = await getAllAdminDeviceTokens();

      // Extract device tokens from adminDeviceTokens
      final List<String> allDeviceTokens = adminDeviceTokens
          .where((admin) => admin['deviceTokens'] != null)
          .expand<String>((admin) => List<String>.from(admin['deviceTokens'] ??
              [])) // Convert dynamic list to List<String>
          .toList();

      return allDeviceTokens;
    } catch (e) {
      throw Exception('Failed to get all device tokens: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllAdminDeviceTokens() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://arcoenergies.onrender.com/admins/device-tokens',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        return List<Map<String, dynamic>>.from(responseData);
      } else {
        throw Exception('Failed to fetch admin device tokens');
      }
    } catch (e) {
      throw Exception('Failed to get admin device tokens: $e');
    }
  }

  // Method to get all operator device tokens from API
  Future<List<Map<String, dynamic>>> getAllOperatorDeviceTokens() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.6.119:8080/api/operator/device-tokens',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        return List<Map<String, dynamic>>.from(responseData);
      } else {
        throw Exception('Failed to fetch operator device tokens');
      }
    } catch (e) {
      throw Exception('Failed to get operator device tokens: $e');
    }
  }

  // Method to get all device tokens from operator data
  Future<List<String>> getAllOpDeviceTokens() async {
    try {
      final operatorDeviceTokens = await getAllOperatorDeviceTokens();

      // Extract device tokens from operatorDeviceTokens
      final List<String> allDeviceTokens = operatorDeviceTokens
          .where((operator) => operator['deviceTokens'] != null)
          .expand<String>(
              (operator) => List<String>.from(operator['deviceTokens'] ?? []))
          .toList();

      return allDeviceTokens;
    } catch (e) {
      throw Exception('Failed to get all operator device tokens: $e');
    }
  }

  Future<List<String>> getOperatorDeviceTokensById(String operatorId) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://192.168.6.119:8080/api/operator/device-tokens/$operatorId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        return List<String>.from(responseData);
      } else {
        throw Exception('Failed to fetch operator device tokens');
      }
    } catch (e) {
      throw Exception('Failed to get operator device tokens: $e');
    }
  }
}
