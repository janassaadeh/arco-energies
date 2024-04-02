import 'package:company_pages/Models/company_response.dart';

class VehicleResponse {
  final String id;
  final int year;
  final String model;
  final String plateNumber;
  final String driverName;
  final String type;
  final String color;
  final CompanyResponse company;

  VehicleResponse({
    required this.id,
    required this.year,
    required this.model,
    required this.plateNumber,
    required this.driverName,
    required this.type,
    required this.color,
    required this.company,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
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
