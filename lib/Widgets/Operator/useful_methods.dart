import 'package:company_pages/Models/fuel.dart';

double? getMostRecentFuelPrice(List<Fuel> fuels, String fuelType) {
  final fuel = fuels.firstWhere(
    (fuel) => fuel.type == fuelType,
    orElse: () =>
        Fuel(id: '', type: '', description: '', prices: [], pumps: []),
  );

  if (fuel.prices.isNotEmpty) {
    final mostRecentPrice = fuel.prices.last;
    return mostRecentPrice.price;
  }

  return null;
}
