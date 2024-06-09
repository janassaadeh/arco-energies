import 'package:company_pages/Services/deposit_service.dart';
import 'package:flutter/material.dart';

class DepositProvider extends ChangeNotifier {
  List<DepositReceipt> cachedDeposits = [];
  DepositReceipt? _generatedDeposit;

  DepositReceipt? get generatedDeposit => _generatedDeposit;

  //  List<DepositReceipt> get depositList => _depositList;
  //    void addDeposit(DepositReceipt newDeposit) {
  //   _depositList.add(newDeposit);
  //   notifyListeners(); // Notify listeners of the change
  // }
  DepositService depositService=DepositService();
  Future<List<DepositReceipt>> getDeposits(String id) async {
    if (cachedDeposits.isNotEmpty) {
      return cachedDeposits;
    } else {
      try {
        final List<DepositReceipt> transactions =
            await depositService.getCashAdditionEventsByAdminId(id);
        cachedDeposits = transactions;
        return transactions;
      } catch (e) {
        throw Exception('Failed to fetch transactions: $e');
      }
    }
  }

}
