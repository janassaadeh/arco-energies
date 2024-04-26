import 'package:company_pages/Models/fuel.dart';
import 'package:company_pages/Models/fuel_price.dart';
import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
// import 'package:company_pages/Services/Operator/fuel_prices_service.dart';
import 'package:company_pages/Models/notification.dart' as not;
import 'package:company_pages/Services/Operator/fuel_service.dart';
import 'package:company_pages/Services/Operator/notification_service.dart';
import 'package:flutter/material.dart';

class FuelPricesProvider extends ChangeNotifier {
  List<FuelPrice> cachedFuelPrices = [];
  List<Fuel> cachedFuels = [];
  List<not.Notification> cachedNotifications = [];

  FuelPricesService fuelPricesService = FuelPricesService();
  FuelService fuelService = FuelService();
  NotificationService notificationService = NotificationService();

  Future<List<FuelPrice>> getFuelPrices() async {
    if (cachedFuelPrices.isNotEmpty) {
      return cachedFuelPrices;
    } else {
      try {
        final vehicles = await fuelPricesService.getFuelPrices();
        cachedFuelPrices = vehicles;
        return vehicles;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }

  Future<List<not.Notification>> getNotifications() async {
    if (cachedNotifications.isNotEmpty) {
      return cachedNotifications;
    } else {
      try {
        final notifications = await notificationService.getAllNotifications();
        cachedNotifications = notifications;
        return notifications;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }

  Future<List<Fuel>> getFuels() async {
    if (cachedFuels.isNotEmpty) {
      return cachedFuels;
    } else {
      try {
        final fuels = await fuelService.getAllFuels();
        cachedFuels = fuels;
        return fuels;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }

  void removeCachedNotification(not.Notification notification) {
    cachedNotifications.remove(notification);
    notifyListeners();
  }

  void clearCachedNotifications() {
    cachedNotifications.clear();
    notifyListeners();
  }
}
