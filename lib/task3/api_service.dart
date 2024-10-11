import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_project/task3/models.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<ApiResponse> fetchData() async {
    final response =
        await _dio.get('https://test-share.shub.edu.vn/api/intern-test/input');
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> sendResults(String token, List<int> results) async {
    try {
      final response = await _dio.post(
        'https://test-share.shub.edu.vn/api/intern-test/output',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
        data: jsonEncode(results),
      );

      if (response.statusCode == 200) {
        print('Results successfully sent: ${response.data}');
      } else {
        print('Failed to send results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending results: $e');
    }
  }
}
