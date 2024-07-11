import 'package:company_pages/Models/shift.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Services/Operator/pump_service.dart';
import 'package:company_pages/Services/Operator/shift_service.dart';
import 'package:company_pages/Services/Operator/transaction_service.dart';
import 'package:company_pages/Services/Operator/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:company_pages/Models/pump.dart';

class TransactionProvider extends ChangeNotifier {
  String _selectedVehicleId = '';
  String _selectedPumpId = '';
  String _enteredOdometerValue = '';
  String _enteredLitersAmount = '';
  List<Pump> cachedPumps = [];
  List<Vehicle> cachedVehicles = [];
  List<Transaction> cachedTransactions = [];
  List<Shift> cachedShifts = [];
  Transaction? _generatedTransaction;
  int isIdTriggeredByNFC = 0;

  String get selectedVehicleId => _selectedVehicleId;
  String get selectedPumpId => _selectedPumpId;
  String get enteredOdometerValue => _enteredOdometerValue;
  String get enteredLitersAmount => _enteredLitersAmount;
  Transaction? get generatedTransaction => _generatedTransaction;

  PumpService pumpService = PumpService();
  VehicleService vehicleService = VehicleService();
  TransactionService transactionService = TransactionService();
  final ShiftService shiftService = ShiftService();

  void setSelectedVehicleId(String id) {
    _selectedVehicleId = id;
    print(id);
    notifyListeners();
  }

  void setSelectedPumpId(String id) {
    _selectedPumpId = id;
    print(id);
    notifyListeners();
  }

  void setOdometerValue(String odometerValue) {
    _enteredOdometerValue = odometerValue;
    print(odometerValue);
    notifyListeners();
  }

  void setLitersValue(String liters) {
    _enteredLitersAmount = liters;
    print(liters);
    notifyListeners();
  }

  void resetTransactionValues() {
    _selectedVehicleId = '';
    _selectedPumpId = '';
    _enteredOdometerValue = '';
    _enteredLitersAmount = '';
    _generatedTransaction = null;
    notifyListeners();
  }

  void storeGeneratedTransaction(Transaction transaction) {
    _generatedTransaction = transaction;
    notifyListeners();
  }

  void isTriggeredByNfc() {
    isIdTriggeredByNFC++;
    print(isIdTriggeredByNFC);
  }

  void isTriggeredBySearch() {
    isIdTriggeredByNFC = 0;
    print(isIdTriggeredByNFC);
  }

  Future<List<Pump>> getPumps() async {
    // Check if pumps are already fetched
    if (cachedPumps.isNotEmpty) {
      return cachedPumps;
    } else {
      try {
        final List<Pump> pumps = await pumpService.getPumps();
        cachedPumps = pumps; // Cache fetched pumps
        return pumps;
      } catch (e) {
        throw Exception('Failed to fetch pumps: $e');
      }
    }
  }

  Future<List<Vehicle>> getVehicles() async {
    if (cachedVehicles.isNotEmpty) {
      return cachedVehicles;
    } else {
      try {
        final List<Vehicle> vehicles = await vehicleService.getVehicles();
        cachedVehicles = vehicles;
        return vehicles;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }

  Future<List<Transaction>> getTransactions() async {
    if (cachedTransactions.isNotEmpty) {
      return cachedTransactions;
    } else {
      try {
        final List<Transaction> transactions =
            await transactionService.getTransactions();
        cachedTransactions = transactions;
        return transactions;
      } catch (e) {
        throw Exception('Failed to fetch transactions: $e');
      }
    }
  }

  Future<List<Shift>> getShifts() async {
    if (cachedShifts.isNotEmpty) {
      return cachedShifts;
    } else {
      try {
        final List<Shift> shifts = await shiftService.getAllShifts();
        cachedShifts = shifts;
        return shifts;
      } catch (e) {
        throw Exception('Failed to fetch vehicles: $e');
      }
    }
  }
}
