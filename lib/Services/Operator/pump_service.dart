import 'package:company_pages/Models/fuel_response.dart';
import 'package:company_pages/Models/operator_response.dart';
import 'package:company_pages/Models/pump.dart';
import 'package:company_pages/Models/pump_response.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle_response.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';

class PumpService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<List<Pump>> getPumps() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://172.20.10.2:8080/api/pumps',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        // Map the response data to Pump objects
        List<Pump> pumps = [];
        for (var pumpJson in responseData) {
          String id = pumpJson['id'];
          String name = pumpJson['name'];
          String currency = pumpJson['currency'];
          String status = pumpJson['status'];
          FuelResponse fuel = FuelResponse.fromJson(pumpJson['fuel']);
          List<Transaction> transactions = [];

          // Map transaction data if available
          if (pumpJson['transactions'] != null) {
            pumpJson['transactions'].forEach((transactionJson) {
              String transactionId = transactionJson['id'];
              double quantity = transactionJson['quantity'];
              double odometer = transactionJson['odometer'];
              String date = transactionJson['date'];

              transactions.add(Transaction(
                  id: transactionId,
                  quantity: quantity,
                  odometer: odometer,
                  date: date,
                  pump: PumpResponse.fromJson(transactionJson['pump']),
                  vehicle: VehicleResponse.fromJson(transactionJson['vehicle']),
                  operator:
                      OperatorResponse.fromJson(transactionJson['operator'])));
            });
          }
          pumps.add(Pump(
            id: id,
            name: name,
            currency: currency,
            status: status,
            transactions: transactions,
            fuel: fuel,
          ));
        }
        print(pumps);
        return pumps;
      } else {
        throw Exception('Failed to load pumps');
      }
    } catch (e) {
      throw Exception('Failed to fetch pumps: $e');
    }
  }
}
