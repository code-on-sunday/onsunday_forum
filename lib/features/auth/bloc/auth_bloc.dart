import 'package:bloc/bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_event.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_state.dart';
import 'package:onsunday_forum/features/auth/data/auth_repository.dart';
import 'package:onsunday_forum/features/result_type.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStarted);
  }

  final AuthRepository authRepository;

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
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

  void _onRegisterStarted(AuthRegisterStarted event, Emitter<AuthState> emit) {}
}
