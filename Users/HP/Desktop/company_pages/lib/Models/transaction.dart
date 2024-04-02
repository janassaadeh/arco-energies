import 'package:company_pages/Models/pump_response.dart';
import 'package:company_pages/Models/vehicle_response.dart';

class Transaction {
  final String id;
  final double quantity;
  final double odometer;
  final String date;
  final PumpResponse pump;
  final VehicleResponse vehicle;

  Transaction({
    required this.id,
    required this.quantity,
    required this.odometer,
    required this.date,
    required this.pump,
    required this.vehicle,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      quantity: json['quantity'],
      odometer: json['odometer'],
      date: json['date'],
      pump: PumpResponse.fromJson(json['pump']),
      vehicle: VehicleResponse.fromJson(json['vehicle']),
    );
  }
}
