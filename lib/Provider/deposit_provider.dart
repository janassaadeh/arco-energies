import 'package:company_pages/Services/deposit_service.dart';
import 'package:flutter/material.dart';

class DepositProvider extends ChangeNotifier {
 List<DepositReceipt> _depositList = [];


   List<DepositReceipt> get depositList => _depositList;
     void addDeposit(DepositReceipt newDeposit) {
    _depositList.add(newDeposit);
    notifyListeners(); // Notify listeners of the change
  }

}
