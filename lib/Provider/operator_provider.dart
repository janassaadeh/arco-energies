import 'package:company_pages/Screens/Admin/Manage%20Companies/Company_Model.dart';
import '../../../Screens/Admin/ManageOperators/operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorProvider extends ChangeNotifier {
  List<Operator> _operatorList = []; // List of companies

  // Getter for the company list
  List<Operator> get operatorList => _operatorList;

  // Method to set the entire company list
  void setOperatorList(List<Operator> newList) {
    _operatorList = newList;
    notifyListeners(); // Notify listeners of the change
  }
}
