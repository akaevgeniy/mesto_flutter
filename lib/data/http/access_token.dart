import 'package:dio/dio.dart';
import 'package:mesto_flutter/data/repository/user_repository.dart';
import 'package:mesto_flutter/di/service_locator.dart';

UserRepository authUser = getIt<UserRepository>();

class AddAccessToken extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await authUser.readUserToken() ?? '';
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }
}
