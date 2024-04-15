import 'fuel_price.dart';
import 'pump.dart';

class Fuel {
  final String id;
  final String type;
  final String description;
  final List<FuelPrice> prices;
  final List<Pump> pumps;

  Fuel({
    required this.id,
    required this.type,
    required this.description,
    required this.prices,
    required this.pumps,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) {
    List<FuelPrice> prices = [];
    if (json['prices'] != null) {
      prices = List<FuelPrice>.from(
        (json['prices'] as List<dynamic>).map(
          (priceJson) => FuelPrice.fromJson(priceJson as Map<String, dynamic>),
        ),
      );
    }

    List<Pump> pumps = [];
    if (json['pumps'] != null) {
      pumps = List<Pump>.from(
        (json['pumps'] as List<dynamic>).map(
          (pumpJson) => Pump.fromJson(pumpJson as Map<String, dynamic>),
        ),
      );
    }

    return Fuel(
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      prices: prices,
      pumps: pumps,
    );
  }
}
