import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'dio_error_cancel'; //TODO: localization error phrase
        break;
      case DioExceptionType.connectionTimeout:
        message = 'dio_error_connection_timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'dio_error_receive_timeout';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'dio_error_send_timeout';
        break;
      case DioExceptionType.unknown:
        if (dioError.error.toString().contains("SocketException")) {
          message = 'dio_error_connection';
          break;
        }
        message = 'dio_error_unknown';
        break;
      default:
        message = 'dio_error_something';
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['error']['reason'] ?? 'status_code_400';
      case 401:
        return error['error']['reason'] ?? 'status_code_401';
      case 403:
        return error['error']['reason'] ?? 'status_code_403';
      case 404:
        return error['error']['reason'] ?? 'status_code_404';
      case 422:
        return error['error']['reason'] ?? 'status_code_422';
      case 500:
        return error['error']['reason'] ?? 'status_code_500';
      case 502:
        return error['error']['reason'] ?? 'status_code_502';
      default:
        return 'status_code_something';
    }
  }

  @override
  String toString() => message;
}
