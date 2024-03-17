import 'package:dio/dio.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';

class TransactionService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<void> addTransaction(
      String pumpId, String vehicleId, double quantity, double odometer) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      if (token == null) {
        throw Exception('Failed to retrieve authentication token');
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://10.0.2.2:8080/custom_api/transactions',
        queryParameters: {'pumpId': pumpId, 'vehicleId': vehicleId},
        data: {
          'quantity': quantity,
          'odometer': odometer,
          'date': "2024-02-13",
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print(
            'Failed to create Transaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Performing Transaction: $e');
      throw Exception('Failed to perform transaction: $e');
    }
  }
}
