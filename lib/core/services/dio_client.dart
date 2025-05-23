// dio_client.dart
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static final Dio _dio = Dio()
    ..options = BaseOptions(
      headers: {
        "Content-Type": "application/json", // For sending JSON data
        "Accept": "application/json", // For expecting JSON response
      },
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
      responseType: ResponseType.json, // Ensures the response is parsed as JSON
    )
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));

  static Dio get instance => _dio;
}
