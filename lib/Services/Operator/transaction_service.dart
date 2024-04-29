import 'package:company_pages/Models/transaction.dart';
import 'package:dio/dio.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';

class TransactionService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<Transaction> addTransaction(String pumpId, String vehicleId,
      double quantity, double odometer, String date) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      if (token == null) {
        throw Exception('Failed to retrieve authentication token');
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(
        'http://172.20.10.3:8080/api/transactions',
        queryParameters: {'pumpId': pumpId, 'vehicleId': vehicleId},
        data: {
          'quantity': quantity,
          'odometer': odometer,
          'date': date,
          'authentication': token,
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        return Transaction.fromJson(response.data);
      } else {
        print(
            'Failed to create Transaction. Status code: ${response.statusCode}');
        // You might want to throw an exception here or return a default value
        throw Exception('Failed to create Transaction');
      }
    } catch (e) {
      print('Error Performing Transaction: $e');
      // Rethrow the exception
      throw Exception('Failed to perform transaction: $e');
    }
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      if (token == null) {
        throw Exception('Failed to retrieve authentication token');
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://172.20.10.3:8080/api/transactions',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        // Map the response data to Transaction objects
        List<Transaction> transactions = [];
        for (var transactionJson in responseData) {
          transactions.add(Transaction.fromJson(transactionJson));
        }
        print(transactions);
        return transactions;
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<List<Transaction>> getTransactionsForCompany(String id) async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      if (token == null) {
        throw Exception('Failed to retrieve authentication token');
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'http://172.20.10.3:8080/api/transactions/company/$id',
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        // Map the response data to Transaction objects
        List<Transaction> transactions = [];
        for (var transactionJson in responseData) {
          transactions.add(Transaction.fromJson(transactionJson));
        }
        print(transactions);
        return transactions;
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }
}
