import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';

class DepositService {
  final Dio _dio = Dio();
  final AuthenticationService authenticationService = AuthenticationService();

  Future<String> addCashRequest(
      double cashAmount, String companyId, String paymentMethod) async {
    final token = await authenticationService.getToken();

    try {
      final response = await _dio.post(
        'https://arcoenergies.onrender.com/deposit/addCash',
        data: {
          "cashAmount": cashAmount,
          "companyId": companyId,
          "paymentMethod": paymentMethod,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle response
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final id = responseData['id'] as String;
        final newBalance = responseData['newBalance'] as double;
        final message = responseData['message'] as String;

        print('Cash added successfully');
        print('ID: $id');
        print('New Balance: $newBalance');
        print('Message: $message');
        return id;
      } else {
        print('Failed to add cash. Status code: ${response.statusCode}');
        // Handle other status codes if needed
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return '';
  }

  Future<Map<String, dynamic>> getDepositReceipt(String receiptId) async {
    final token = await authenticationService.getToken();
    try {
      final response = await _dio.get(
        'http://192.168.20.59:8080/deposit/receipt/$receiptId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        // DepositReceipt receipt = DepositReceipt.fromJson(response.data);
        return response.data;
      } else {
        throw Exception(
            'Failed to load deposit receipt. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<DepositReceipt>> getCashAdditionEventsByAdminId(
      String adminId) async {
    final token = await authenticationService.getToken();

    try {
      final response = await _dio.get(
        'http://192.168.20.59:8080/deposit/admin/$adminId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final receipts = responseData
            .map((receiptData) => DepositReceipt.fromJson(receiptData))
            .toList();
        return receipts;
      } else {
        throw Exception(
            'Failed to get deposit receipts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<DepositReceipt>> getCashAdditionEventsByCompanyId(
      String companyId) async {
    final token = await authenticationService.getToken();

    try {
      final response = await _dio.get(
        'http://192.168.20.59:8080/deposit/company/$companyId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final receipts = responseData
            .map((receiptData) => DepositReceipt.fromJson(receiptData))
            .toList();
        return receipts;
      } else {
        throw Exception(
            'Failed to get deposit receipts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}

void printDepositReceipt(Map<String, dynamic> receipt) {
  print('Deposit Receipt:');
  print('ID: ${receipt['id']}');
  print('Company:');
  print('  ID: ${receipt['company']['id']}');
  print('  Email: ${receipt['company']['email']}');
  print('  Phone: ${receipt['company']['phone']}');
  print('  Name: ${receipt['company']['name']}');
  print('  Balance: ${receipt['company']['balance']}');
  print('  Contact Name: ${receipt['company']['contactName']}');
  print('  Location: ${receipt['company']['location']}');
  print('Admin:');
  print('  ID: ${receipt['admin']['id']}');
  print('  Email: ${receipt['admin']['email']}');
  print('  Phone: ${receipt['admin']['phone']}');
  print('  Name: ${receipt['admin']['name']}');
  print('  DOB: ${receipt['admin']['dob']}');
  print('Payment Method: ${receipt['paymentMethod']}');
  print('Cash Amount: ${receipt['cashAmount']}');
  print('Timestamp: ${receipt['timestamp']}');
}

class DepositReceipt {
  final String id;
  final String companyId;
  final String companyEmail;
  final String companyPhone;
  final String companyName;
  final double companyBalance;
  final String companyContactName;
  final String companyLocation;
  final String adminId;
  final String adminEmail;
  final String adminPhone;
  final String adminName;
  final String adminDob;
  final String paymentMethod;
  final double cashAmount;
  final String timestamp;

  DepositReceipt({
    required this.id,
    required this.companyId,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyName,
    required this.companyBalance,
    required this.companyContactName,
    required this.companyLocation,
    required this.adminId,
    required this.adminEmail,
    required this.adminPhone,
    required this.adminName,
    required this.adminDob,
    required this.paymentMethod,
    required this.cashAmount,
    required this.timestamp,
  });

  factory DepositReceipt.fromJson(Map<String, dynamic> json) {
    return DepositReceipt(
      id: json['id'],
      companyId: json['company']['id'],
      companyEmail: json['company']['email'],
      companyPhone: json['company']['phone'],
      companyName: json['company']['name'],
      companyBalance: json['company']['balance'].toDouble(),
      companyContactName: json['company']['contactName'],
      companyLocation: json['company']['location'],
      adminId: json['admin']['id'],
      adminEmail: json['admin']['email'],
      adminPhone: json['admin']['phone'],
      adminName: json['admin']['name'],
      adminDob: json['admin']['dob'],
      paymentMethod: json['paymentMethod'],
      cashAmount: json['cashAmount'].toDouble(),
      timestamp: json['timestamp'],
    );
  }
}
