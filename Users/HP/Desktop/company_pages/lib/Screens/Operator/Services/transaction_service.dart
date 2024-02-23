import 'package:dio/dio.dart';

class TransactionService {
  Future<void> addTransaction(String pumpId, String vehicleId, double quantity,
      double odometer, String date) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://localhost:8080/custom_api/transactions',
        queryParameters: {'pumpId': pumpId, 'vehicleId': vehicleId},
        data: {
          'quantity': quantity,
          'odometer': odometer,
          'date': date,
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print(
            'Failed to create Transaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error here
      print('Error Performing Transaction: $e');
    }
  }
}
