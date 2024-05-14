import 'package:dio/dio.dart';

class PasswordResetService {
  final Dio _dio = Dio();

  Future<void> initiatePasswordReset(String email) async {
    try {
      Response response = await _dio.post(
        'http://192.168.6.114:8080/api/v1/auth/reset-password/initiate',
        queryParameters: {'email': email},
      );
      print('Initiate Password Reset Response: ${response.data}');
    } catch (e) {
      print('Error initiating password reset: $e');
      // Handle error
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    try {
      Response response = await _dio.post(
        'http://192.168.6.114:8080/api/v1/auth/reset-password/confirm',
        queryParameters: {'token': token, 'newPassword': newPassword},
      );
      print('Reset Password Response: ${response.data}');
    } catch (e) {
      print('Error resetting password: $e');
      // Handle error
    }
  }
}
