import 'package:bloc/bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:onsunday_forum/features/auth/data/auth_repository.dart';
import 'package:onsunday_forum/features/result_type.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStarted);
    on<AuthLoginPrefilled>(_onLoginPrefilled);
    on<AuthAuthenticateStarted>(_onAuthenticateStarted);
    on<AuthLogoutStarted>(_onLogoutStarted);
  }

  final AuthRepository authRepository;

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthAuthenticateUnauthenticated());
  }

  void _onLoginStarted(AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    await Future.delayed(1.seconds);
    final result = await authRepository.login(
        username: event.username, password: event.password);
    return (switch (result) {
      Success() => emit(AuthLoginSuccess()),
      Failure() => emit(AuthLoginFailure(result.message)),
    });
  }

  void _onLoginPrefilled(
      AuthLoginPrefilled event, Emitter<AuthState> emit) async {
    emit(AuthLoginInitial(username: event.username, password: event.password));
  }

  void _onRegisterStarted(
      AuthRegisterStarted event, Emitter<AuthState> emit) async {
    emit(AuthRegisterInProgress());
    final result = await authRepository.register(
        username: event.username, password: event.password);
    return (switch (result) {
      Success() => emit(AuthRegisterSuccess()),
      Failure() => emit(AuthRegisterFailure(result.message)),
    });
  }

  void _onAuthenticateStarted(
      AuthAuthenticateStarted event, Emitter<AuthState> emit) async {
    final result = await authRepository.getToken();
    return (switch (result) {
      Success(data: final token) when token != null =>
        emit(AuthAuthenticateSuccess(token)),
      Success() => emit(AuthAuthenticateUnauthenticated()),
      Failure() => emit(AuthAuthenticateFailure(result.message)),
    });
  }

  void _onLogoutStarted(
      AuthLogoutStarted event, Emitter<AuthState> emit) async {
    final result = await authRepository.logout();
    return (switch (result) {
      Success() => emit(AuthLogoutSuccess()),
      Failure() => emit(AuthLogoutFailure(result.message)),
    });
  }
}
