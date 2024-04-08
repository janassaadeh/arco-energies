import 'package:dio/dio.dart';

class RegistrationService {
  final Dio _dio = Dio();

  Future<RegistrationResponse> registerCompany({
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
      
      // Parse the response data and return a RegistrationResponse object
      return RegistrationResponse.fromJson(response.data);
    } catch (e) {
      print('Error during registration: $e');
      rethrow;
    }
  }
    Future<RegistrationResponse> registerOperator({
    required String name,
    required String email,
    required String password,
    required String dob,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/api/v1/auth/operator/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'dob': dob,
          'address': address,
        },
      );
      
      // Parse the response data and return a RegistrationResponse object
      return RegistrationResponse.fromJson(response.data);
    } catch (e) {
      print('Error during registration: $e');
      rethrow;
    }
  }
}

class RegistrationResponse {
  final String token;
  final String message; // Assuming message contains the user ID

  RegistrationResponse({required this.token, required this.message});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      token: json['token'],
      message: json['message'],
    );
  }
}
