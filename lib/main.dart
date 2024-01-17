import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onsunday_forum/config/http_client.dart';
import 'package:onsunday_forum/config/router.dart';
import 'package:onsunday_forum/config/theme.dart';
import 'package:onsunday_forum/features/auth/bloc/auth_bloc.dart';
import 'package:onsunday_forum/features/auth/data/auth_api_client.dart';
import 'package:onsunday_forum/features/auth/data/auth_local_data_source.dart';
import 'package:onsunday_forum/features/auth/data/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sf = await SharedPreferences.getInstance();
  runApp(MainApp(
    sharedPreferences: sf,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(
        authApiClient: AuthApiClient(dio),
        authLocalDataSource: AuthLocalDataSource(sharedPreferences),
      ),
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthRepository>(),
        ),
        child: AppContent(),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({
    super.key,
  });

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthInitial) {
      return Container();
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: router,
    );
  }
}
