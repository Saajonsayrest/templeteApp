import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/config/endpoints.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/dio_client.dart';
import '../models/home_respone.dart';

class DataSource {
  final Dio _dio = DioClient.instance;

  Future<HomeResponse> home() async {
    try {
      final response = await _dio.get(EndpointsUrl.homeUrl);

      if (response.statusCode == 200 && response.data != null) {
        return HomeResponse.fromJson(response.data);
      } else {
        throw UnexpectedFailure('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('DataSource.home error: $e');
      if (e is DioException) {
        throw UnexpectedFailure('Dio error: ${e.message}');
      }
      throw UnexpectedFailure('Unknown error: ${e.toString()}');
    }
  }
}
