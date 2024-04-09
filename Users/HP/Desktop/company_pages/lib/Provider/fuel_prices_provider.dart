import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:flutter/material.dart';

class FuelPricesProvider extends ChangeNotifier {
  List<FuelPrice> cachedFuelPrices = [];

  FuelPricesService fuelPricesService = FuelPricesService();

  Future<List<FuelPrice>> getFuelPrices() async {
    if (cachedFuelPrices.isNotEmpty) {
      return cachedFuelPrices;
    } else {
      try {
        final List<FuelPrice> vehicles =
            await fuelPricesService.getFuelPrices();
        cachedFuelPrices = vehicles;
        return vehicles;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }
}
