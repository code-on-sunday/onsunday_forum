import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onsunday_forum/config/router.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_bloc.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_event.dart';
import 'package:onsunday_forum/utils/theme_ext.dart';
import 'package:onsunday_forum/widgets/single_child_scroll_view_with_column.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthRegisterStarted(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollViewWithColumn(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register new account',
              style: context.text.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.color.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 48,
                ),
                decoration: BoxDecoration(
                  color: context.color.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: AutofillGroup(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autofillHints: const [AutofillHints.username],
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          controller: _passwordController,
                          autofillHints: const [AutofillHints.newPassword],
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () {
                            _handleSubmit(context);
                          },
                          label: Text('Submit'),
                          icon: Icon(Icons.arrow_forward),
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () {
                            context.go(RouteName.login);
                          },
                          child: Text('Already have an account? Login'),
                        ),
                      ]
                          .animate(
                            interval: 50.ms,
                          )
                          .slideX(
                            begin: -0.1,
                            end: 0,
                            curve: Curves.easeInOutCubic,
                            duration: 400.ms,
                          )
                          .fadeIn(
                            curve: Curves.easeInOutCubic,
                            duration: 400.ms,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}