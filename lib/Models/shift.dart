import 'package:company_pages/Models/operator_response.dart';
import 'package:company_pages/Models/transaction.dart';
import 'package:company_pages/Services/deposit_service.dart';

class Shift {
  final String id;
  final OperatorResponse operator;
  final DateTime startTime;
  final DateTime? endTime; // Allow endTime to be nullable
  final double totalTransactionsAmount;
  final List<Transaction> transactions;
  final double totalDepositsAmount;
  final List<DepositReceipt> deposits;
  final String status;

  Shift({
    required this.id,
    required this.operator,
    required this.startTime,
    required this.endTime,
    required this.totalTransactionsAmount,
    required this.transactions,
    required this.totalDepositsAmount,
    required this.deposits,
    required this.status,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] ?? '',
      operator: OperatorResponse.fromJson(json['operator'] ?? {}),
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      totalTransactionsAmount: (json['totalTransactionsAmount'] ?? 0).toDouble(),
      transactions: (json['transactions'] as List<dynamic>? ?? [])
          .map((data) => Transaction.fromJson(data))
          .toList(),
      totalDepositsAmount: (json['totalDepositsAmount'] ?? 0).toDouble(),
      deposits: (json['deposits'] as List<dynamic>? ?? [])
          .map((data) => DepositReceipt.fromJson(data))
          .toList(),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operator': operator.toJson(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'totalTransactionsAmount': totalTransactionsAmount,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
      'totalDepositsAmount': totalDepositsAmount,
      'deposits': deposits.map((deposit) => deposit.toJson()).toList(),
      'status': status,
    };
  }
}
