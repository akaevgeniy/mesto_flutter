import 'package:dio/dio.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/bloc/auth_bloc.dart';

class CheckAuth extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final authBloc = getIt<AuthBloc>();
      authBloc.add(UserLogout());
    }
    return super.onError(err, handler);
  }
}
