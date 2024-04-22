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
        'http://10.0.2.2:8080/api/fuel_prices',
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
        'http://10.0.2.2:8080/api/fuel_prices',
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
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      for (var fuelPrice in fuelPrices) {
        final notificationMessage = {
          'receiptToken':
              'cfmNH1LzRMmctSfIpnB_g6:APA91bGq_A1eJzplNxo8DP40oYnI-wApFx5ExOtWf1sR8PK36scoYfUbpTfdruUkeV4qibho45zKGqiL8ujkON0b4UXW6XzGzxhTohTHDPsFXaP_S9-c26VMjxeZ9DpgmAQn_MGid2KK',
          'title': 'New Fuel Prices List',
          'body': 'The price of ${fuelPrice.id} is ${fuelPrice.price}',
        };

        final response = await dio.post(
          'http://10.0.2.2:8080/api/notifications',
          data: notificationMessage,
        );

        if (response.statusCode == 200) {
          print('Push notification sent successfully');
        } else {
          print('Failed to send push notification');
        }
      }
    } catch (e) {
      throw Exception('Failed to send push notifications: $e');
    }
  }
}
