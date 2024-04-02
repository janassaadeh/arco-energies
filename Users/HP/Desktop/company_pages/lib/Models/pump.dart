import 'package:company_pages/Models/fuel_response.dart';
import 'package:company_pages/Models/transaction.dart';

class Pump {
  final String id;
  final String name;
  final String status;
  final List<Transaction> transactions;
  final FuelResponse fuel;

  Pump({
    required this.id,
    required this.name,
    required this.status,
    required this.transactions,
    required this.fuel,
  });

  factory Pump.fromJson(Map<String, dynamic> json) {
    List<Transaction> transactions = [];
    if (json['transactions'] != null) {
      transactions = List<Transaction>.from(
        json['transactions'].map(
          (transactionJson) => Transaction.fromJson(transactionJson),
        ),
      );
    }

    return Pump(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      transactions: transactions,
      fuel: FuelResponse.fromJson(json['fuel']), // Parse fuel from JSON
    );
  }
}
