// import 'package:your_app/models/shift.dart';
// import 'package:your_app/models/operator.dart';
// import 'package:your_app/models/transaction.dart';
// import 'package:your_app/models/cash_addition_event.dart';
// import 'package:dio/dio.dart';

// class ShiftService {
//   final Dio dio = Dio();
//   // You may need an authentication service if your API requires authentication

//   Future<Shift> createShiftWithCustomId(
//     DateTime startTime,
//     DateTime endTime,
//     List<Transaction> transactions,
//     List<CashAdditionEvent> deposits,
//     Operator operator,
//   ) async {
//     try {
//       // Assuming you have an endpoint to create a new shift
//       final response = await dio.post(
//         'https://your-api.com/api/shifts',
//         data: {
//           'startTime': startTime.toIso8601String(),
//           'endTime': endTime.toIso8601String(),
//           'transactions':
//               transactions.map((transaction) => transaction.toJson()).toList(),
//           'deposits': deposits.map((deposit) => deposit.toJson()).toList(),
//           'operator': operator.toJson(),
//         },
//       );

//       if (response.statusCode == 200) {
//         // Assuming your backend returns the created shift in the response
//         final createdShift = Shift.fromJson(response.data);
//         return createdShift;
//       } else {
//         throw Exception('Failed to create shift');
//       }
//     } catch (e) {
//       throw Exception('Failed to create shift: $e');
//     }
//   }

//   Future<Shift> getShiftById(String id) async {
//     try {
//       final response = await dio.get(
//         'https://your-api.com/api/shifts/$id',
//       );

//       if (response.statusCode == 200) {
//         final shiftData = response.data;
//         final shift = Shift.fromJson(shiftData);
//         return shift;
//       } else {
//         throw Exception('Failed to fetch shift by ID');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch shift by ID: $e');
//     }
//   }

//   Future<List<Shift>> getAllShifts() async {
//     try {
//       final response = await dio.get(
//         'https://your-api.com/api/shifts',
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = response.data;
//         final shifts =
//             responseData.map((data) => Shift.fromJson(data)).toList();
//         return shifts;
//       } else {
//         throw Exception('Failed to fetch all shifts');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch all shifts: $e');
//     }
//   }

//   Future<Shift> updateShift(
//     String id,
//     Operator operator,
//     DateTime startTime,
//     DateTime endTime,
//     List<Transaction> transactions,
//     List<CashAdditionEvent> deposits,
//   ) async {
//     try {
//       final response = await dio.put(
//         'https://your-api.com/api/shifts/$id',
//         data: {
//           'operator': operator.toJson(),
//           'startTime': startTime.toIso8601String(),
//           'endTime': endTime.toIso8601String(),
//           'transactions':
//               transactions.map((transaction) => transaction.toJson()).toList(),
//           'deposits': deposits.map((deposit) => deposit.toJson()).toList(),
//         },
//       );

//       if (response.statusCode == 200) {
//         final updatedShiftData = response.data;
//         final updatedShift = Shift.fromJson(updatedShiftData);
//         return updatedShift;
//       } else {
//         throw Exception('Failed to update shift');
//       }
//     } catch (e) {
//       throw Exception('Failed to update shift: $e');
//     }
//   }

//   Future<void> deleteShiftById(String id) async {
//     try {
//       final response = await dio.delete(
//         'https://your-api.com/api/shifts/$id',
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to delete shift by ID');
//       }
//     } catch (e) {
//       throw Exception('Failed to delete shift by ID: $e');
//     }
//   }

//   Future<void> deleteAllShifts() async {
//     try {
//       final response = await dio.delete(
//         'https://your-api.com/api/shifts',
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to delete all shifts');
//       }
//     } catch (e) {
//       throw Exception('Failed to delete all shifts: $e');
//     }
//   }
// }
