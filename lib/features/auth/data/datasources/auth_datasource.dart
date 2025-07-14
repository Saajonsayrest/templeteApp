import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:testing/features/auth/data/models/default_response.dart';

import '../../../../core/config/endpoints.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/dio_client.dart';

class AuthDataSource {
  final Dio _dio = DioClient.instance;

  Future<DefaultResponse> login() async {
    try {
      final response = await _dio.get(EndpointsUrl.loginUrl);

      if (response.statusCode == 200 && response.data != null) {
        return DefaultResponse.fromJson(response.data);
      } else {
        throw UnexpectedFailure('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('LoginDataSource error: $e');
      if (e is DioException) {
        throw UnexpectedFailure('Dio error: ${e.message}');
      }
      throw UnexpectedFailure('Unknown error: ${e.toString()}');
    }
  }
}
