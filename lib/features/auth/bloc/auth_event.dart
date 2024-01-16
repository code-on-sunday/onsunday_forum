part of 'auth_bloc.dart';

class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  AuthLoginStarted({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class AuthLoginPrefilled extends AuthEvent {
  AuthLoginPrefilled({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class AuthRegisterStarted extends AuthEvent {
  AuthRegisterStarted({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
