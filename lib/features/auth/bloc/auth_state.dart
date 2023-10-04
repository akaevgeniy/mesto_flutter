part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AppAuthenticated extends AuthState {}

class AppAforeAuthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}

class AuthenticationSuccess extends AuthState {}

class AuthenticationStart extends AuthState {}

class UserLogoutState extends AuthState {}

class UserLogoutLoading extends AuthState {}

class UserLogoutFailure extends AuthState {
  const UserLogoutFailure({
    required this.exception,
  });
  final Object? exception;
}

class RegisterSuccess extends AuthState {
  const RegisterSuccess({
    required this.profile,
  });
  final Object? profile;
}

class AuthenticationFailure extends AuthState {
  const AuthenticationFailure({
    required this.exception,
  });
  final Object? exception;
}

class UserRegisterFailure extends AuthState {
  const UserRegisterFailure({
    required this.exception,
  });
  final Object? exception;
}
