import 'package:company_pages/Models/fuel_response.dart';

class FuelPrice {
  final String id;
  final double price;
  final String createdDate;
  final FuelResponse fuelResponse;

  FuelPrice({
    required this.id,
    required this.price,
    required this.createdDate,
    required this.fuelResponse,
  });

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      createdDate: json['createdDate'] as String,
      fuelResponse: FuelResponse.fromJson(json['fuelResponse']),
    );
  }
}
