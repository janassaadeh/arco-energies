import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';

import '../../Screens/Admin/ManageOperators/operator_model.dart';
// import '../Auth/AuthenticationService.dart';

class ManageDepositService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://arcoenergies.onrender.com';

  Future<void> updateDeposit(String id, String companyId,
      double cashAmount, String paymentMethod) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.put(
          '$_baseUrl/deposit/deposits/$id',
          queryParameters: {
            'companyId': companyId,
            'cashAmount': cashAmount,
            'paymentMethod': paymentMethod,
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

  Future<void> deleteDeposit(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        await _dio.delete(
          '$_baseUrl/deposit/deposits/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } else {
        
        throw Exception('User is not logged in');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to delete transaction: $e');
    }
  }
}
