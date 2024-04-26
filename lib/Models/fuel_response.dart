class FuelResponse {
  String? id;
  final String type;
  final String description;
  double? fuelPrice;

  FuelResponse({
    this.id,
    required this.type,
    required this.description,
    this.fuelPrice,
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
