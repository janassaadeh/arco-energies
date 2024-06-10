import 'package:company_pages/Models/fuel_response.dart';

class PumpResponse {
  final String id;
  final String name;
  final String currency;
  final String status;
  final FuelResponse fuel;

  PumpResponse({
    required this.id,
    required this.name,
    required this.currency,
    required this.status,
    required this.fuel,
  });

  factory PumpResponse.fromJson(Map<String, dynamic> json) {
    return PumpResponse(
      id: json['id'],
      name: json['name'],
      currency: json['currency'],
      status: json['status'],
      fuel: FuelResponse.fromJson(json['fuel']),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'status': status,
      'fuel': fuel.toJson(),
    };
  }
}
