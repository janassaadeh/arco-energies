import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';
import 'package:company_pages/Models/fuel_price.dart';

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
        'http://192.168.6.114:8080/api/fuel_prices',
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
        'http://192.168.6.114:8080/api/fuel_prices',
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

  Future<void> sendPushNotifications(List<FuelPrice> fuelPrices) async {
    try {
      final List<String> allDeviceTokens = await getAllDeviceTokens();

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
        notificationMessage['receiptToken'] =
            deviceToken; // Set device token in notification message
        final response = await dio.post(
          'http://192.168.6.114:8080/api/notifications/push',
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

  Future<List<String>> getAllDeviceTokens() async {
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
        'http://192.168.6.114:8080/admins/device-tokens',
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
}
