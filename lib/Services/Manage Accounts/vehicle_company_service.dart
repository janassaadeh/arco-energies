// import 'dart:convert';

import 'package:company_pages/Models/vehicle.dart';
import 'package:dio/dio.dart';

import '../Auth/AuthenticationService.dart';

class VehicleCompanyService {
  Dio _dio=Dio(); // Create Dio instance
final String _baseUrl = 'http://10.0.2.2:8080/api';

  

Future<Vehicle> addVehicleForCompany(String companyId, String type, int year, String model, String plateNumber, String driverName, String color) async {
  try {
    final authenticationService = AuthenticationService();
    final token = await authenticationService.getToken();
    if (token != null) {
      var response = await _dio.post(
        '$_baseUrl/vehicles/company/$companyId',
        queryParameters: {
          'companyId':companyId,
          'type': type,
          'year': year,
          'model': model,
          'plateNumber': plateNumber,
          'driverName': driverName,
          'color': color,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
     Vehicle vehicle= Vehicle.fromJson(response.data);
      return vehicle;
    } else {
      throw Exception('Failed to obtain authentication token.');
    }
  } catch (error) {
    throw error;
  }
}


Future<List<Vehicle>> getVehiclesForCompany(String companyId) async {
  try {
    
    final authenticationService = AuthenticationService();
    final token = await authenticationService.getToken();
    if (token != null) {
      var response = await _dio.get(
        '$_baseUrl/vehicles/company/$companyId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
           if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        List<Vehicle> vehicles = [];
        for (var vehicleJson in responseData) {
          vehicles.add(Vehicle.fromJson(vehicleJson));
        }
        print(vehicles);
        return vehicles;
      } else {
        throw Exception('Failed to load vehicles');
      }
    } else {
      throw Exception('Failed to obtain authentication token.');
    }
  } catch (error) {
    throw error;
  }
}

Future<Response> updateVehicleForCompany(String companyId, String vehicleId, String type, int year, String model, String plateNumber, String driverName, String color) async {
  try {
    final authenticationService = AuthenticationService();
    final token = await authenticationService.getToken();
    if (token != null) {
      var response = await _dio.put(
        '$_baseUrl/vehicles/company/$companyId/vehicle/$vehicleId',
        queryParameters: {
          'type': type,
          'year': year,
          'model': model,
          'plateNumber': plateNumber,
          'driverName': driverName,
          'color': color,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } else {
      throw Exception('Failed to obtain authentication token.');
    }
  } catch (error) {
    throw error;
  }
}

Future<Response> deleteVehicleForCompany(String companyId, String vehicleId) async {
  try {
    final authenticationService = AuthenticationService();
    final token = await authenticationService.getToken();
    if (token != null) {
      var response = await _dio.delete(
        '$_baseUrl/vehicles/company/$companyId/vehicle/$vehicleId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } else {
      throw Exception('Failed to obtain authentication token.');
    }
  } catch (error) {
    throw error;
  }
}

}
