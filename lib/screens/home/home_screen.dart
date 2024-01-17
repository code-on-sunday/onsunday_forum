import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onsunday_forum/config/router.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogoutStarted());
  }

  @override
  Widget build(BuildContext context) {
    final widget = Scaffold(
      body: Column(
        children: [
          FilledButton(
            onPressed: () => _handleLogout(context),
            child: Text('Log out'),
          ),
        ],
      ),
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.pushReplacement(RouteName.login);
        }
      },
      child: widget,
    );
  }
}
