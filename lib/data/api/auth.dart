import 'package:dio/dio.dart';
import 'package:mesto_flutter/data/http/dio_client.dart';
import 'package:mesto_flutter/data/http/dio_exeption.dart';
import 'package:mesto_flutter/data/http/endpoints.dart';

class AuthApi {
  final DioClient dioClient;

  AuthApi({required this.dioClient});

  Future<Response> authApi(dynamic data) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.auth, data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> registerApi(dynamic data) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.register, data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> authLogoutApi() async {
    try {
      final Response response = await dioClient.post(Endpoints.logout);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
