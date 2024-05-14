import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:company_pages/Services/Auth/AuthenticationService.dart';

class ImageService {
  final Dio _dio = Dio();

  // Define a method to upload an image with an authorization token
  Future<void> uploadImage(String base64Image, String userId) async {
    try {
      // Encode the base64Image to send in the request body
      String encodedImage = base64Image.replaceAll('\n', '');

      // Retrieve the authorization token
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();

      if (token != null) {
        // Make a POST request to upload the image
        await _dio.post(
          'https://arcoenergies.onrender.com/images/upload?userId=$userId',
          data: {'base64Image': encodedImage},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      }
    } catch (e) {
      // Handle errors
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  // Define a method to fetch an image with an authorization token
  Future<Uint8List> getImageFromId(String id) async {
    try {
      // Retrieve the authorization token
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();

      if (token != null) {
        // Set the authorization token in the request headers
        _dio.options.headers['Authorization'] = 'Bearer $token';

        // Make a GET request to fetch the image
        final Response<Uint8List> response = await _dio.get(
          'https://arcoenergies.onrender.com/images/$id',
          options: Options(responseType: ResponseType.bytes),
        );

        // Return the image data
        return response.data!;
      } else {
        throw Exception('Failed to get image: Token is null');
      }
    } catch (e) {
      // Handle errors
      print('Failed to get image: $e');
      throw Exception('Failed to get image: $e');
    }
  }

  // uploadImageForCar(base64image1, String id) {}

  Future<void> uploadImageForCar(String base64Image, String carId) async {
    try {
      // Encode the base64Image to send in the request body
      String encodedImage = base64Image.replaceAll('\n', '');

      // Retrieve the authorization token
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        // Make a POST request to upload the image
        await _dio.post(
          'https://arcoenergies.onrender.com/images/vehicle/upload?vehicleId=$carId',
          data: {'base64Image': encodedImage},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      }
    } catch (e) {
      // Handle errors
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }
}
