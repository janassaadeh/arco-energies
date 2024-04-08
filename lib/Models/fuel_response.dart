class FuelResponse {
  final String id;
  final String type;
  final String description;
  final double fuelPrice;

  FuelResponse({
    required this.id,
    required this.type,
    required this.description,
    required this.fuelPrice,
  });

  factory FuelResponse.fromJson(Map<String, dynamic> json) {
    return FuelResponse(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      fuelPrice: json['fuelPrice'],
    );
  }
}
