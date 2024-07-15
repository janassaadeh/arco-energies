import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarProvider extends ChangeNotifier {
  List<Vehicle> _carList = []; // List of companies


  // Getter for the company list
  List<Vehicle> get carList => _carList;

  void setCarList(List<Vehicle> newList) {
    _carList = newList;
    notifyListeners(); // Notify listeners of the change
  }
}
