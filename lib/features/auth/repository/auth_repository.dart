import 'package:dio/dio.dart';
import 'package:mesto_flutter/data/api/auth.dart';
import 'package:mesto_flutter/data/http/dio_exeption.dart';
import 'package:mesto_flutter/data/models/response_model.dart';

class AuthRepository {
  final AuthApi authApi;
  AuthRepository(this.authApi);

  Future<ResponseModel> authRequested(
      {required String email, required String password}) async {
    try {
      final response = await authApi.authApi({
        "email": email,
        "password": password,
      });

      final convertResponse = ResponseModel.fromJson(response.data);

      return convertResponse;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> registerRequested({
    required String password,
    required String email,
  }) async {
    try {
      final response = await authApi.registerApi({
        "email": email,
        "password": password,
      });
      final responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> authLogoutRequested() async {
    try {
      final response = await authApi.authLogoutApi();
      final responseData = response.data;
      return responseData;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
