import 'package:company_pages/Models/company_response.dart';

class Vehicle {
  final String id;
  final int year;
  final String model;
  final String plateNumber;
  final String driverName;
  final String type;
  final String color;
  CompanyResponse? company;

  Vehicle({
    required this.id,
    required this.year,
    required this.model,
    required this.plateNumber,
    required this.driverName,
    required this.type,
    required this.color,
    this.company,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      year: json['year'],
      model: json['model'],
      plateNumber: json['plateNumber'],
      driverName: json['driverName'],
      type: json['type'],
      color: json['color'],
      company: CompanyResponse.fromJson(json['company']),
    );
  }
}
