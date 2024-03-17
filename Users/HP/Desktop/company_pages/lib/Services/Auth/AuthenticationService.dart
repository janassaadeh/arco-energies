import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final Dio _dio = Dio();
  final String _tokenKey = 'auth_token';
  final String _roleKey = 'user_role';

  Future<bool> authenticate(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/api/v1/auth/authenticate',
        data: {'email': email, 'password': password},
      );

      String token = response.data['token'];
      String role = response.data['role'];
      await _saveToken(token);
      await _saveRole(role);

      return true;
    } catch (e) {
      print('Error during authentication: $e');
      rethrow;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> _saveRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    return token != null;
  }

  Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
  }
}
