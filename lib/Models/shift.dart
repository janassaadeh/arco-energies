import 'package:company_pages/Models/operator_response.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Services/deposit_service.dart';

class Shift {
  final String id;
  final OperatorResponse operator;
  final DateTime startTime;
  final DateTime endTime;
  final double totalTransactionsAmount;
  final List<Transaction> transactions;
  final double totalDepositsAmount;
  final List<DepositReceipt> deposits;

  Shift({
    required this.id,
    required this.operator,
    required this.startTime,
    required this.endTime,
    required this.totalTransactionsAmount,
    required this.transactions,
    required this.totalDepositsAmount,
    required this.deposits,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      operator: OperatorResponse.fromJson(json['operator']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      totalTransactionsAmount: json['totalTransactionsAmount'],
      transactions: (json['transactions'] as List<dynamic>)
          .map((data) => Transaction.fromJson(data))
          .toList(),
      totalDepositsAmount: json['totalDepositsAmount'],
      deposits: (json['deposits'] as List<dynamic>)
          .map((data) => DepositReceipt.fromJson(data))
          .toList(),
    );
  }

}
