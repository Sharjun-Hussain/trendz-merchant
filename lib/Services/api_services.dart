import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trendz_merchant/Models/branches_modal.dart';
import 'package:trendz_merchant/Models/service_modal.dart';
import 'dart:convert' as env;

const securestorage = FlutterSecureStorage();

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://35.169.19.237:8000",
    headers: {"Content-Type": "application/json"},
  ));

  // Login with email and password
  Future<Map<String, dynamic>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final response = await _dio.post('/api/merchant/login', data: {
        "email": email,
        "password": password,
      });
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw e.response?.data["message"] ?? "Login failed";
      }
      throw "An unexpected error occurred";
    }
  }

  Future<Services> fetchServices() async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.get(
        '/api/merchant/services',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Services.fromJson(response.data is String
                ? env.jsonDecode(response.data) // Decode if it's a String
                : response.data // Use directly if it's already a Map
            );
      } else {
        throw Exception(
            'Internal Server Error. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Future<List<Map<String, dynamic>>> fetchServices() async {
  //   try {
  //     final token = await securestorage.read(key: "token");
  //     final response = await _dio.get(
  //       '/api/merchant/services',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = response.data['data'];
  //       return responseData.cast<Map<String, dynamic>>();
  //     } else {
  //       throw Exception(
  //           'Failed to fetch services. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

  // Update service status
  Future<void> updateServiceStatus(int serviceId, int value) async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.put('/api/merchant/services/$serviceId',
          data: {'isEnabled': value},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode != 200) {
        throw Exception('Failed to update service status');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Create a new service
  Future<String> createService(Map<String, dynamic> serviceData) async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.post(
        '/api/merchant/services',
        data: serviceData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw Exception(
            'Failed to create service. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Update service details
  Future<Map<String, dynamic>> updateService(
      int serviceId, Map<String, dynamic> serviceData) async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.put(
        '/api/merchant/services/$serviceId',
        data: serviceData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to update service. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> deleteService({required int serviceid}) async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.delete(
        '/api/merchant/services/$serviceid',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final String responseData = response.data['message'];
        return responseData;
      } else {
        throw Exception(
            'Failed to fetch services. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch all branches
  Future<List<Branches>> fetchBranches() async {
    try {
      final token = await securestorage.read(key: "token");
      final response = await _dio.get(
        '/api/merchant/branches',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data'];
        return data.map((json) => Branches.fromJson(json)).toList();
      }
      throw Exception('Failed to fetch branches');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
