import 'package:company_pages/Models/redemption_model.dart';
import 'package:company_pages/Screens/Admin/Rewards/redemption.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// import '../Screens/Company/RewardScreen.dart';
import '../Models/reward_model.dart';
import 'Auth/AuthenticationService.dart';
import 'dart:typed_data';

class RewardService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://arcoenergies.onrender.com';
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
    Future<List<Reward>> getAllRewards() async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.get(
          '$_baseUrl/api/rewards',
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
    Future<dynamic> updateReward(String id, Reward reward) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.put(
          '$_baseUrl/api/rewards/update/$id',
          data: {
            "id":reward.id,
            "name":reward.name,
            "description":reward.description,
            "pts":reward.pts,
            "category":reward.category
                      },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return true;
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to update operator: $e');
    }
  }

    Future<dynamic> assignRewards(String name,String description,String category,int pts) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        final response = await _dio.post(
          '$_baseUrl/api/rewards/assign/all',
          data: {
            "name":name,
            "description":description,
            "category":category,
            "pts":pts
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        return response.data;
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to add reward: $e');
    }
  }
  Future<void> deleteReward(String id) async {
    try {
      final authenticationService = AuthenticationService();
      final token = await authenticationService.getToken();
      if (token != null) {
        await _dio.delete(
          '$_baseUrl/api/rewards/delete/$id',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      throw Exception('Failed to delete operator: $e');
    }
  }

    Future<List<RedemptionEvent>> getRedemptions() async {
  try {
    final authenticationService = AuthenticationService();
    final token = await authenticationService.getToken();
    if (token != null) {
      final response = await _dio.get(
        '$_baseUrl/api/rewards/redemptions',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      
      // Check if response data is a String
      if (response.data is String) {
        // Handle the case where response data is a String
        throw Exception('Response data is a String instead of a List<dynamic>');
      }
      
      // Parse response data assuming it's a List<dynamic>
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => RedemptionEvent.fromJson(json)).toList();
    } else {
      throw Exception('User is not logged in');
    }
  } catch (e) {
    throw Exception('Failed to fetch redemptions: $e');
  }
}

}
