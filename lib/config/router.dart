import 'package:go_router/go_router.dart';
import 'package:onsunday_forum/screens/home/home_screen.dart';
import 'package:onsunday_forum/screens/login/login_screen.dart';
import 'package:onsunday_forum/screens/post_detail/post_detail_screen.dart';
import 'package:onsunday_forum/screens/profile/profile_screen.dart';
import 'package:onsunday_forum/screens/register/register_screen.dart';

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String postDetail = '/post/:id';
  static const String profile = '/profile';
  static const String register = '/register';

  static const publicRoutes = [
    login,
    register,
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    // If user is not logged in, redirect to login page
    return RouteName.login;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RouteName.postDetail,
      builder: (context, state) => PostDetailScreen(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: RouteName.profile,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => RegisterScreen(),
    ),
  ],
);
