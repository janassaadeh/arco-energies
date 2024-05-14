import 'package:company_pages/Services/Auth/AuthenticationService.dart';
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
        'https://arcoenergies.onrender.com/api/v1/auth/company/register',
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

  Future<RegistrationResponse> registerCompanyByAdmin({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double balance,
    required String contactName,
    required String location,
  }) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.post(
          'https://arcoenergies.onrender.com/admins/company/register',
          data: {
            'email': email,
            'password': password,
            'name': name,
            'phone': phone,
            'balance':
                0, // Assuming you want to use the provided balance parameter here
            'contactName': contactName,
            'location': location,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        // Parse the response data and return a RegistrationResponse object
        return RegistrationResponse.fromJson(response.data);
      }
      // If token is null, handle accordingly
      throw ('Token is null');
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
        'https://arcoenergies.onrender.com/api/v1/auth/operator/register',
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
