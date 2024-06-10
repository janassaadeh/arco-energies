import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Services/deposit_service.dart';
import 'package:flutter/material.dart';

class ShiftProvider extends ChangeNotifier {
  String _startShiftTime = '';
  String _endShiftTime = '';
  bool _isDuringShift = false;
  List<Transaction> _transactions = [];
  List<DepositReceipt> _deposits = [];

  String get startShiftTime => _startShiftTime;
  String get endShiftTime => _endShiftTime;
  bool get isDuringShift => _isDuringShift;
  List<Transaction> get transactions => _transactions;
  List<DepositReceipt> get deposits => _deposits;

  void setStartShiftTime(String time) {
    _startShiftTime = time;
    _isDuringShift = true;
    print('Shift started at: $time');
    notifyListeners();
  }

  void setEndShiftTime(String time) {
    _endShiftTime = time;
    _isDuringShift = false;
    print('Shift ended at: $time');
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
      _transactions.add(transaction);
      print('Transaction added: ${transaction.id}');
      notifyListeners();
  }

  void addDeposit(DepositReceipt deposit) {
      _deposits.add(deposit);
      print('Deposit added: ${deposit.id}');
      notifyListeners();
  
  }

  void resetShiftTimes() {
    _startShiftTime = '';
    _endShiftTime = '';
    _isDuringShift = false;
    _transactions.clear();
    _deposits.clear();
    notifyListeners();
  }

  // List<Transaction> filterTransactionsByShift(List<Transaction> transactions) {
  //   if (_startShiftTime.isEmpty || _endShiftTime.isEmpty) {
  //     return [];
  //   }

  //   DateTime startShift = DateTime.parse(_startShiftTime);
  //   DateTime endShift = DateTime.parse(_endShiftTime);

  //   print(startShift);
  //   print(endShift);

  //   return transactions.where((transaction) {
  //     DateTime transactionTime = DateTime.parse(transaction.date);
  //     print(transaction.date);
  //     return transactionTime.isAfter(startShift) &&
  //         transactionTime.isBefore(endShift);
  //   }).toList();
  // }

  // List<DepositReceipt> filterDepositsByShift(List<DepositReceipt> deposits) {
  //   if (_startShiftTime.isEmpty || _endShiftTime.isEmpty) {
  //     return [];
  //   }

  //   DateTime startShift = DateTime.parse(_startShiftTime);
  //   DateTime endShift = DateTime.parse(_endShiftTime);

  //   print(startShift);
  //   print(endShift);

  //   return deposits.where((deposit) {
  //     DateTime depositTime = DateTime.parse(deposit.timestamp);
  //     print(deposit.timestamp);
  //     return depositTime.isAfter(startShift) && depositTime.isBefore(endShift);
  //   }).toList();
  // }
}
