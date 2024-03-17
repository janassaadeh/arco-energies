import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  String _selectedVehicleId = '';
  String _selectedPumpId = '';
  String _enteredOdometerValue = '';
  String _enteredLitersAmount = '';

  String get selectedVehicleId => _selectedVehicleId;
  String get selectedPumpId => _selectedPumpId;
  String get enteredOdometerValue => _enteredOdometerValue;
  String get enteredLitersAmount => _enteredLitersAmount;

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
}
