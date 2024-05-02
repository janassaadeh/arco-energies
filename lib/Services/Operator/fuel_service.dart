import 'package:dio/dio.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Models/fuel.dart';

class FuelService {
  final Dio _dio = Dio();
  final AuthenticationService _authService = AuthenticationService();

  Future<List<Fuel>> getAllFuels() async {
    try {
      final bool isLoggedIn = await _authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await _authService.getToken();
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get(
        'http://172.20.10.2:8080/api/fuels', // Adjust the URL as per your API endpoint
      );

      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;
        if (responseData == null) {
          throw Exception('Response data is null');
        }

        List<Fuel> fuels = [];
        for (var fuelJson in responseData) {
          if (fuelJson is Map<String, dynamic>) {
            fuels.add(Fuel.fromJson(fuelJson));
          }
        }
        return fuels;
      } else {
        throw Exception('Failed to load fuels');
      }
    } catch (e) {
      throw Exception('Failed to fetch fuels: $e');
    }
  }
}
