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

  // Future<void> sendPushNotifications(List<FuelPrice> fuelPrices) async {
  //   try {
  //     final bool isLoggedIn = await authService.isLoggedIn();
  //     if (!isLoggedIn) {
  //       throw Exception('User is not logged in');
  //     }

  //     final String? token = await authService.getToken();
  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     final List<Map<String, dynamic>> fuelPriceDetails = fuelPrices
  //         .map((fuelPrice) => {
  //               'id': fuelPrice.id,
  //               'price': fuelPrice.price,
  //             })
  //         .toList();

  //     String fuelPricesDetails = '';
  //     for (var fuelPrice in fuelPrices) {
  //       fuelPricesDetails +=
  //           '${fuelPrice.id}: ${fuelPrice.price.toStringAsFixed(2)}\n';
  //     }

  //     final notificationMessage = {
  //       'receiptToken':
  //           'faFA4_8mR7Sx9jkQBL29xk:APA91bFMAQPcAUht3ze2zhVHY8NV8RjMA4Ox6yKduMWt47Ix50dugV8l3M6uj3eOwQbvOVVBHbbEze_jc0KTsrrNoqdDMHtlOKPiIcv8t_sVLi8NEaGgbf7PBsT5u4gJFAlUjHgVxvkS',
  //       'title': 'New Fuel Prices List',
  //       'body': 'Fuel prices details: $fuelPriceDetails',
  //     };

  //     final response = await dio.post(
  //       'http://10.0.2.2:8080/api/notifications/push',
  //       data: notificationMessage,
  //     );

  //     if (response.statusCode == 200) {
  //       print('Push notification sent successfully');
  //     } else {
  //       print('Failed to send push notification');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to send push notifications: $e');
  //   }
  // }

  Future<void> sendPushNotifications(List<FuelPrice> fuelPrices) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final List<Map<String, dynamic>> fuelPriceDetails = fuelPrices
          .map((fuelPrice) => {
                'id': fuelPrice.fuelResponse!.type,
                'price': fuelPrice.price,
              })
          .toList();

      String fuelPricesDetails = '';
      for (var fuelPrice in fuelPrices) {
        fuelPricesDetails +=
            '${fuelPrice.fuelResponse!.type}: ${fuelPrice.price.toStringAsFixed(2)}, ';
      }
      fuelPricesDetails =
          fuelPricesDetails.trim().replaceAll(RegExp(r',\s*$'), '');

      final notificationMessage = {
        'receiptToken':
            'd-AQXwA2QOaUrpVdgJwnDb:APA91bH6Ku7nZpjqVLs0X9BZIRF-KM5L4Cib6LCR5YvzrooyXQe-mb8KYH_IAZ6B71OexV1bHXc57PjBaiRKFhB1fytZPUQDRIoaJcuJOjseBIE_DKT-g5V7m6VTzjjkgGnlj5c8mZd-',
        'title': 'New Fuel Prices List',
        'body': 'Fuel prices details: $fuelPricesDetails',
      };

      final response = await dio.post(
        'http://10.0.2.2:8080/api/notifications/push',
        data: notificationMessage,
      );

      if (response.statusCode == 200) {
        print('Push notification sent successfully');
      } else {
        print('Failed to send push notification');
      }
    } catch (e) {
      throw Exception('Failed to send push notifications: $e');
    }
  }
}
