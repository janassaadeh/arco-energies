import 'package:dio/dio.dart';

import '../../Screens/Admin/ManageOperators/operator_model.dart';
import '../Auth/AuthenticationService.dart';

class ManageTransactionService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.20.59:8080';

  Future<void> updateTransaction(String id, String pumpId, String vehicleId,
      double quantity, double odometer) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.put(
          '$_baseUrl/api/transactions/$id',
          queryParameters: {
            'pumpId': pumpId,
            'vehicleId': vehicleId,
            'quantity': quantity,
            'odometer': odometer,
          },
          //     queryParameters: {
          //   'type': type??'',
          //   'year': year??'',
          //   'model': model??'',
          //   'plateNumber': plateNumber??'',
          //   'driverName': driverName??'',
          //   'color': color??'',
          // },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        // Handle response if needed
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to update transaction: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        await _dio.delete(
          '$_baseUrl/api/transactions/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }
}
