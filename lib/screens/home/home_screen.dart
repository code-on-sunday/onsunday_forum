import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onsunday_forum/config/router.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_bloc.dart';
import 'package:onsunday_forum/utils/theme_ext.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogoutStarted());
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Scaffold(
      body: Column(
        children: [
          Text('Home Screen'),
          FilledButton(
            onPressed: () => _handleLogout(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    widget = BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLogoutSuccess():
            context.read<AuthBloc>().add(AuthStarted());
            context.pushReplacement(RouteName.login);
            break;
          case AuthLogoutFailure(message: final msg):
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Logout Failure'),
                  content: Text(msg),
                  backgroundColor: context.color.surface,
                );
              },
            );
          default:
        }
      },
      child: widget,
    );

    return widget;
  }
}
