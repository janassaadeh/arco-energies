import 'package:dio/dio.dart';

class RegistrationService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> registerCompany({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double balance,
    required String contactName,
    required String location,
  }) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/api/v1/auth/company/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'balance': 0,
          'contactName': contactName,
          'location': location,
        },
      );

      return response.data;
    } catch (e) {
      print('Error during registration: $e');
      rethrow;
    }
  }
}
