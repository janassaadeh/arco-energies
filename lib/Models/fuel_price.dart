import 'fuel_response.dart';

class FuelPrice {
  String? id;
  final double price;
  final String createdDate;
  FuelResponse? fuelResponse; // Allow fuelResponse to be nullable

  FuelPrice({
    this.id,
    required this.price,
    required this.createdDate,
    this.fuelResponse,
  });

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      createdDate: json['createdDate'] as String,
      fuelResponse: json['fuel'] != null
          ? FuelResponse.fromJson(json['fuel'] as Map<String, dynamic>)
          : null, // Handle nullable case
    );
  }
}
