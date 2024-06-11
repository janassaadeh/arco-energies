import 'package:company_pages/Models/shift.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Screens/Admin/ManageOperators/operator_model.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:dio/dio.dart';

class ShiftService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<Shift> createShift(
    DateTime startTime,
    DateTime endTime,
    List<String> transactionIds,
    List<String> depositIds,
  ) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://192.168.6.118:8080/api/shifts',
        data: {
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'transactionIds': transactionIds,
          'depositIds': depositIds,
        },
      );

      if (response.statusCode == 200) {
        final shiftData = response.data;
        final shift = Shift.fromJson(shiftData);
        return shift;
      } else {
        throw Exception('Failed to create shift');
      }
    } catch (e) {
      throw Exception('Failed to create shift: $e');
    }
  }

  Future<Shift> getShiftById(String id) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://arcoenergies.onrender.com/api/shifts/$id',
      );

      if (response.statusCode == 200) {
        final shiftData = response.data;
        final shift = Shift.fromJson(shiftData);
        return shift;
      } else {
        throw Exception('Failed to fetch shift by ID');
      }
    } catch (e) {
      throw Exception('Failed to fetch shift by ID: $e');
    }
  }

  Future<List<Shift>> getAllShifts() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://arcoenergies.onrender.com/api/shifts',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final shifts =
            responseData.map((data) => Shift.fromJson(data)).toList();
        return shifts;
      } else {
        throw Exception('Failed to fetch all shifts');
      }
    } catch (e) {
      throw Exception('Failed to fetch all shifts: $e');
    }
  }

  Future<Shift> updateShift(
    String id,
    Operator operator,
    DateTime startTime,
    DateTime endTime,
    List<Transaction> transactions,
    List<DepositReceipt> deposits,
  ) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.put(
        'https://arcoenergies.onrender.com/api/shifts/$id',
        data: {
          'operator': operator.toJson(),
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'transactions': transactions,
          'deposits': deposits,
        },
      );

      if (response.statusCode == 200) {
        final updatedShiftData = response.data;
        final updatedShift = Shift.fromJson(updatedShiftData);
        return updatedShift;
      } else {
        throw Exception('Failed to update shift');
      }
    } catch (e) {
      throw Exception('Failed to update shift: $e');
    }
  }

  Future<void> deleteShiftById(String id) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.delete(
        'https://arcoenergies.onrender.com/api/shifts/$id',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete shift by ID');
      }
    } catch (e) {
      throw Exception('Failed to delete shift by ID: $e');
    }
  }

  Future<void> deleteAllShifts() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.delete(
        'https://arcoenergies.onrender.com/api/shifts',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete all shifts');
      }
    } catch (e) {
      throw Exception('Failed to delete all shifts: $e');
    }
  }
}
