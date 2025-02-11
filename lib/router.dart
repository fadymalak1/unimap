// TODO: Implement router.dart

import 'package:go_router/go_router.dart';
import 'features/auth/views/getStarted_view.dart';
import 'features/auth/views/login_view.dart';
import 'features/auth/views/register_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
