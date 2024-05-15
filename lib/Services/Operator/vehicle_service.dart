import 'package:dio/dio.dart';
import 'package:company_pages/Models/vehicle.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';

class VehicleService {
  final Dio dio = Dio();
  final AuthenticationService authService = AuthenticationService();

  Future<List<Vehicle>> getVehicles() async {
    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      if (!isLoggedIn) {
        throw Exception('User is not logged in');
      }

      final String? token = await authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        'https://arcoenergies.onrender.com/api/vehicles',
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
    } catch (e) {
      throw Exception('Failed to fetch vehicles: $e');
    }
  }
}
