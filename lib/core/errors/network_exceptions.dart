import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(int? statusCode, dynamic response) {
    // Treat status code 400 as a success case
    if (statusCode == 400) {
      if (response != null && response['response'] == true) {
        // Successful login response
        return const NetworkExceptions.badRequest(); // Or a success-specific message
      } else {
        // Handle unexpected response even for status code 400
        return const NetworkExceptions.defaultError('Unexpected response for status code 400');
      }
    }

    // All other status codes are treated as failure cases
    switch (statusCode) {
      case 401:
        return const NetworkExceptions.unauthorizedRequest();
      case 403:
        return const NetworkExceptions.unauthorizedRequest();
      case 404:
        return const NetworkExceptions.notFound('Not found');
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      case 300:
      // You can customize this as needed for other codes, e.g., for custom error handling
        if (response != null && response['response'] == false) {
          return NetworkExceptions.defaultError(response['msg'] ?? 'User logged in unsuccessfully');
        }
        return const NetworkExceptions.defaultError('Unexpected server response');
      default:
        final responseCode = statusCode;
        return NetworkExceptions.defaultError(
          'Received invalid status code: $responseCode',
        );
    }
  }

  static String handleErrorToString<T>(dynamic e) {
    try {
      if (e is DioException && e.response?.data != null) {
        if (((e.response?.data as Map?)?['error'] as Map?)?['message'] == null) {
          return NetworkExceptions.getErrorMessage(
            NetworkExceptions.getDioException(e),
          );
        }
        return NetworkExceptions.getErrorMessage(
          NetworkExceptions.defaultError(
            (((e.response?.data as Map)['error'] as Map)['message']).toString(),
          ),
        );
      } else {
        return NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        );
      }
    } catch (e) {
      return NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  static NetworkExceptions getDioException(dynamic error) {
    if (error is DioException) {
      if (kDebugMode) {
        print('++ Dio Error Type: ${error.type}');
        print('++ Dio Error Message: ${error.message}');
        print('++ Dio Error Response: ${error.response}');
      }
      // Check for response error with custom status code
      if (error.response?.statusCode == 300) {
        final responseData = error.response?.data;
        return NetworkExceptions.handleResponse(error.response?.statusCode, responseData);
      }

      switch (error.type) {
        case DioExceptionType.cancel:
          return const NetworkExceptions.requestCancelled();
        case DioExceptionType.connectionTimeout:
          return const NetworkExceptions.requestTimeout();
        case DioExceptionType.unknown:
          return const NetworkExceptions.noInternetConnection();
        case DioExceptionType.receiveTimeout:
          return const NetworkExceptions.sendTimeout();
        case DioExceptionType.sendTimeout:
          return const NetworkExceptions.sendTimeout();
        default:
          return const NetworkExceptions.unexpectedError();
      }
    } else if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    } else {
      return const NetworkExceptions.unexpectedError();
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = '';
    networkExceptions.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Allowed';
      },
      badRequest: () {
        errorMessage = 'Bad request';
      },
      unauthorizedRequest: () {
        errorMessage = 'Invalid Credentials';
      },
      unexpectedError: () {
        errorMessage = 'Oops !! Something wrong :( ';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage =
        'No internet connection! Check your network connection and try again';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
    );
    return errorMessage;
  }
}
