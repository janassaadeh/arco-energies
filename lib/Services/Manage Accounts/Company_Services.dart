import 'package:dio/dio.dart';

import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';

import '../Auth/AuthenticationService.dart';

class CompanyService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.6.112:8080';

  Future<List<Company>> getAllCompanies() async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/company/all',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        final List<dynamic> responseData = response.data;
        return responseData.map((json) => Company.fromJson(json)).toList();
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }

  Future<Company> getCompanyById(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/company/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return Company.fromJson(response.data);
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to fetch company: $e');
    }
  }

  Future<Company> updateCompany(String id, Company company) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.put(
          '$_baseUrl/api/company/$id',
          data: company.toJson(),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return Company.fromJson(response.data);
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to update company: $e');
    }
  }

  Future<void> deleteCompany(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        await _dio.delete(
          '$_baseUrl/api/company/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to delete company: $e');
    }
  }
}
