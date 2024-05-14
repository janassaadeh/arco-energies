import 'package:dio/dio.dart';

import '../../Screens/Admin/ManageOperators/operator_model.dart';
import '../Auth/AuthenticationService.dart';

class OperatorService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://arcoenergies.onrender.com';

  Future<List<Operator>> getAllOperators() async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/operator/all',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        final List<dynamic> responseData = response.data;
        return responseData.map((json) => Operator.fromJson(json)).toList();
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to fetch operator: $e');
    }
  }

  Future<Operator> getOperatorById(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/operator/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return Operator.fromJson(response.data);
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to fetch company: $e');
    }
  }

  Future<Operator> updateOperator(String id, Operator operator) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.put(
          '$_baseUrl/api/operator/$id',
          data: operator.toJson(),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return Operator.fromJson(response.data);
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to update operator: $e');
    }
  }

  Future<void> deleteOperator(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        await _dio.delete(
          '$_baseUrl/api/operator/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to delete operator: $e');
    }
  }
}
