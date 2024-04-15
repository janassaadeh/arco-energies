import 'transaction.dart';
import 'fuel_response.dart';

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
        (json['transactions'] as List<dynamic>).map(
          (transactionJson) =>
              Transaction.fromJson(transactionJson as Map<String, dynamic>),
        ),
      );
    }

    return Pump(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      transactions: transactions,
      fuel: json['fuel'] != null
          ? FuelResponse.fromJson(json['fuel'] as Map<String, dynamic>)
          : FuelResponse(
              id: '',
              type: '',
              description: '',
              fuelPrice: 0.0), // Provide default value or handle nullable case
    );
  }
}
