import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/features/auth/controller.dart';
import 'package:unimap/features/auth/views/login_view.dart';
import 'package:unimap/features/auth/views/register_view.dart';
import 'package:unimap/features/home/views/home_view.dart';
import 'package:unimap/shared/utils.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash', // Start with the splash screen
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(path: '/register', builder: (context, state) => const RegisterView()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
  ],
);

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authState.when(
        data: (user) {
          if (user != null) {
            context.go('/home'); // Go to home if user is logged in
          } else {
            context.go('/login'); // Otherwise, go to login
          }
        },
        loading: () {}, // Keep showing splash
        error: (_, __) => context.go('/login'), // Handle errors by redirecting to login
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppImages.logo, height: 150)), // Show a loading screen
    );
  }
}
