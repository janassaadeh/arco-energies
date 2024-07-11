// import 'package:company_pages/Models/transaction.dart';
// import 'package:company_pages/Services/deposit_service.dart';
// import 'package:flutter/material.dart';

// class ShiftProvider extends ChangeNotifier {
//   String _startShiftTime = '';
//   String _endShiftTime = '';
//   bool _isDuringShift = false;
//   List<String> _transactionsIds = [];
//   List<String> _depositsIds = [];

//   String get startShiftTime => _startShiftTime;
//   String get endShiftTime => _endShiftTime;
//   bool get isDuringShift => _isDuringShift;
//   List<String> get transactionsIds => _transactionsIds;
//   List<String> get depositsIds => _depositsIds;

//   void setStartShiftTime(String time) {
//     _startShiftTime = time;
//     _isDuringShift = true;
//     print('Shift started at: $time');
//     notifyListeners();
//   }

//   void setEndShiftTime(String time) {
//     _endShiftTime = time;
//     _isDuringShift = false;
//     print('Shift ended at: $time');
//     notifyListeners();
//   }

//   void addTransaction(String transactionId) {
//       _transactionsIds.add(transactionId);
//       print('Transaction added: ${transactionId}');
//       notifyListeners();
//   }

//   void addDeposit(String depositId) {
//       _depositsIds.add(depositId);
//       print('Deposit added: $depositId}');
//       notifyListeners();
  
//   }

//   void resetShiftTimes() {
//     _startShiftTime = '';
//     _endShiftTime = '';
//     _isDuringShift = false;
//     _transactionsIds.clear();
//     _depositsIds.clear();
//     notifyListeners();
//   }

//   // List<Transaction> filterTransactionsByShift(List<Transaction> transactions) {
//   //   if (_startShiftTime.isEmpty || _endShiftTime.isEmpty) {
//   //     return [];
//   //   }

//   //   DateTime startShift = DateTime.parse(_startShiftTime);
//   //   DateTime endShift = DateTime.parse(_endShiftTime);

//   //   print(startShift);
//   //   print(endShift);

//   //   return transactions.where((transaction) {
//   //     DateTime transactionTime = DateTime.parse(transaction.date);
//   //     print(transaction.date);
//   //     return transactionTime.isAfter(startShift) &&
//   //         transactionTime.isBefore(endShift);
//   //   }).toList();
//   // }

//   // List<DepositReceipt> filterDepositsByShift(List<DepositReceipt> deposits) {
//   //   if (_startShiftTime.isEmpty || _endShiftTime.isEmpty) {
//   //     return [];
//   //   }

//   //   DateTime startShift = DateTime.parse(_startShiftTime);
//   //   DateTime endShift = DateTime.parse(_endShiftTime);

//   //   print(startShift);
//   //   print(endShift);

//   //   return deposits.where((deposit) {
//   //     DateTime depositTime = DateTime.parse(deposit.timestamp);
//   //     print(deposit.timestamp);
//   //     return depositTime.isAfter(startShift) && depositTime.isBefore(endShift);
//   //   }).toList();
//   // }
// }
