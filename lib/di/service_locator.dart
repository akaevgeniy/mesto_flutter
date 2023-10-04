import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mesto_flutter/data/api/auth.dart';
import 'package:mesto_flutter/data/http/dio_client.dart';
import 'package:mesto_flutter/data/models/auth_user.dart';
import 'package:mesto_flutter/data/repository/user_repository.dart';
import 'package:mesto_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:mesto_flutter/features/auth/repository/auth_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(talker);
  getIt.registerSingleton(AuthUser(email: ''));
  getIt.registerSingleton(UserRepository(getIt.get<AuthUser>()));
  getIt.registerSingleton(AuthApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(AuthRepository(getIt.get<AuthApi>()));
  getIt.registerSingleton(AuthBloc(getIt.get<AuthRepository>()));
  getIt.registerSingleton(UserProfile(UserProfile.empty()));
}
