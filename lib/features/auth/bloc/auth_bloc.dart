import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:mesto_flutter/data/models/auth_user.dart';
import 'package:mesto_flutter/data/repository/user_repository.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository authUser = getIt<UserRepository>();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppLoadedup>((event, emit) async {
      try {
        emit(AuthenticationLoading());

        final isUserRegister = await authUser.isUserRegister() ?? false;

        if (isUserRegister) {
          await authUser.setUserRegister(true);
          emit(AppAuthenticated());
        } else {
          emit(AuthenticationStart());
        }
      } catch (e) {
        emit(AuthenticationFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<UserAuth>((event, emit) async {
      try {
        emit(AuthenticationLoading());

        final data = await authRepository.authRequested(
            email: event.email, password: event.password);
        if (data.success) {
          final user = AuthUser(
            email: event.email,
          );
          authUser.user = user;
          emit(AuthenticationSuccess());
        } else {
          AuthenticationFailure(exception: data.error);
        }
      } catch (e) {
        emit(AuthenticationFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<UserRegister>((event, emit) async {
      try {
        emit(AuthenticationLoading());

        final data = await authRepository.registerRequested(
            email: event.email, password: event.password);
        if (data['success'] == true) {
          authUser.setUserRegister(true);
          emit(RegisterSuccess(profile: data['result']['profile']));
        } else {
          UserRegisterFailure(exception: data.error);
        }
      } catch (e) {
        emit(UserRegisterFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<UserLogout>((event, emit) async {
      try {
        emit(UserLogoutLoading());
        await authRepository.authLogoutRequested();
        authUser.clear();
        authUser.deleteUserToken();
        emit(UserLogoutState());
      } catch (e) {
        UserLogoutFailure(exception: e);
      }
    });
  }

  final AuthRepository authRepository;
}
