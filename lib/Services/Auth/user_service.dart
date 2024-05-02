import 'package:company_pages/Services/Auth/AuthenticationService.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio();

  Future<dynamic> fetchUserData() async {
    try {
      AuthenticationService authenticationService = AuthenticationService();

      // Print the token for debugging
      String? token = await authenticationService.getToken();
      print('Token: $token');

      // Set up headers with the token
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Make GET request to the specified URL with the token
      Response response = await _dio.get(
        'http://172.20.10.2:8080/users/identity',
        options: options,
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response data
        Map<String, dynamic> responseData = response.data;
        print('Response Data: $responseData');
        String? role = await authenticationService.getRole();
        print(role);

        // Determine user type based on the received data
        if (role == 'ADMIN') {
          return Admin.fromJson(responseData); // Parse as Admin object
        } else if (role == 'OPERATOR') {
          return Operator.fromJson(responseData); // Parse as Operator object
        } else if (role == 'COMPANY') {
          return Company.fromJson(responseData); // Parse as Company object
        } else {
          // Handle unrecognized user role
          print('Error: Unrecognized user role');
          return null;
        }
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle Dio errors
      print('Error: $e');
      return null;
    }
  }
}

class User {
  final String id;
  final String email;
  final String phone;
  final String name;

  User(
      {required this.id,
      required this.email,
      required this.phone,
      required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
    );
  }
}

class Admin extends User {
  final String dob;
  final String imageId;

  Admin(
      {required String id,
      required String email,
      required String phone,
      required String name,
      required this.dob,
      required this.imageId})
      : super(id: id, email: email, phone: phone, name: name);

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      dob: json['dob'] ?? '',
      imageId: json['imageId'] ?? '',
    );
  }
}

class Operator extends User {
  final String imageId;
  final String dob;
  final String address;

  Operator(
      {required String id,
      required String email,
      required String phone,
      required String name,
      required this.imageId,
      required this.dob,
      required this.address})
      : super(id: id, email: email, phone: phone, name: name);

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      imageId: json['imageId'] ?? '',
      dob: json['dob'],
      address: json['address'],
    );
  }
}

class Company extends User {
  final double balance;
  final String contactName;
  final String location;
  final int pts;
  final String imageId;
  final bool activate;
  Company(
      {required String id,
      required String email,
      required String phone,
      required String name,
      required this.balance,
      required this.contactName,
      required this.location,
      required this.pts,
      required this.imageId,
      required this.activate})
      : super(id: id, email: email, phone: phone, name: name);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json['id'],
        email: json['email'],
        phone: json['phone'],
        name: json['name'],
        balance: json['balance'],
        contactName: json['contactName'],
        location: json['location'],
        pts: json['pts'],
        imageId: json['imageId'] ?? '',
        activate: json['activate'] ?? false);
  }
}
