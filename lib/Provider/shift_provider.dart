import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Services/Operator/shift_service.dart';

class ShiftProvider extends ChangeNotifier {
  bool isDuringShift = false;
  final ShiftService shiftService = ShiftService();

  Future<bool> getShiftStatus() async {
  if (isDuringShift != false) {
    return isDuringShift;
  } else {
    try {
      final isDuringShiftFuture = await shiftService.getCurrentShift();
      isDuringShift = isDuringShiftFuture;
      print("Is During Shift $isDuringShift");
      notifyListeners();
      return isDuringShift;
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 403) {
        return false;
      } else {
        throw Exception('Failed to fetch Shift Status: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Failed to fetch Shift Status: $e');
    }
  }
}
}
