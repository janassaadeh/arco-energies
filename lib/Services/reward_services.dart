import 'package:dio/dio.dart';

import '../Screens/Company/RewardScreen.dart';
import 'Auth/AuthenticationService.dart';
import 'dart:typed_data';

class RewardService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.6.112:8080';
  Future<Uint8List> getQrCode(String companyId, String rewardId) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/reward/qr-code',
          queryParameters: {
            'companyId': companyId,
            'rewardId': rewardId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
            responseType: ResponseType.bytes, // Ensure response type is bytes
          ),
        );
        // Check if response status is successful
        if (response.statusCode == 200) {
          // Return the response data as Uint8List
          return Uint8List.fromList(response.data);
        } else {
          // Handle non-successful response
          print('Failed to fetch QR code: ${response.statusCode}');
          // throw DioError(response: response);
          throw DioException(
              requestOptions: RequestOptions(path: ''), response: response);
        }
      } else {
        // Handle case where token is null
        throw Exception('Token is null');
      }
    } catch (e) {
      // Handle error if request fails
      print('Error fetching QR code: $e');
      rethrow; // Rethrow the error for external handling
    }
  }

  Future<List<Reward>> getRewards(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/rewards/user/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        final List<dynamic> responseData = response.data;
        return responseData.map((json) => Reward.fromJson(json)).toList();
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to fetch rewards: $e');
    }
  }

  Future<void> redeemReward(String userId, String rewardId) async {
    // @PathVariable String userId, @RequestParam String rewardId
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.post(
          '$_baseUrl/api/rewards/redeem/$userId',
          queryParameters: {
            'rewardId': rewardId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
            responseType: ResponseType.bytes, // Ensure response type is bytes
          ),
        );
        // Check if response status is successful
        if (response.statusCode == 200) {
          // Return the response data as Uint8List
        } else {
          // Handle non-successful response
          print('Failed to redeem: ${response.statusCode}');
          // throw DioError(response: response);
          throw DioException(
              requestOptions: RequestOptions(path: ''), response: response);
        }
      } else {
        // Handle case where token is null
        throw Exception('Token is null');
      }
    } catch (e) {
      // Handle error if request fails
      print('Error fetching QR code: $e');
      rethrow; // Rethrow the error for external handling
    }
  }
}
