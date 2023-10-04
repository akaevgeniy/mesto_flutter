part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UserAuth extends AuthEvent {
  final String email;
  final String password;
  final Completer? completer;

  const UserAuth({
    required this.email,
    required this.password,
    this.completer,
  });

  @override
  List<Object> get props => [email, password];
}

class UserRegister extends AuthEvent {
  final String email;
  final String password;
  final Completer? completer;

  const UserRegister({
    required this.email,
    required this.password,
    this.completer,
  });

  @override
  List<Object> get props => [email, password];
}

class AppLoadedup extends AuthEvent {
  final Completer? completer;

  const AppLoadedup({
    this.completer,
  });
}

class UserLogout extends AuthEvent {}
