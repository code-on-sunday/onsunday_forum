part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginInitial extends AuthState {
  AuthLoginInitial({required this.username, required this.password});

  final String username;
  final String password;
}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message);

  final String message;
}

class AuthRegisterInProgress extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterFailure extends AuthState {
  AuthRegisterFailure(this.message);

  final String message;
}

class AuthAuthenticateSuccess extends AuthState {
  AuthAuthenticateSuccess(this.token);

  final String token;
}

class AuthAuthenticateUnauthenticated extends AuthState {}

class AuthAuthenticateFailure extends AuthState {
  AuthAuthenticateFailure(this.message);

  final String message;
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  AuthLogoutFailure(this.message);

  final String message;
}
