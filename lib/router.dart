import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:unimap/features/auth/views/getStarted_view.dart';
import 'package:unimap/features/auth/views/login_view.dart';
import 'package:unimap/features/auth/views/register_view.dart';
import 'package:unimap/features/favourites/views/favourites_view.dart';
import 'package:unimap/features/home/views/home_view.dart';
import 'package:unimap/features/profile/views/profile_view.dart';
import 'package:unimap/features/search/views/search_view.dart';
import 'package:unimap/features/video/views/video_view.dart';
import 'package:unimap/features/auth/views/change_password.dart';
import 'package:unimap/features/home/views/layout.dart';
import 'package:unimap/features/home/model.dart'; // Import ClassModel

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePassword(),
    ),
    GoRoute(
      path: '/video',
      builder: (context, state) {
        final classItem = state.extra as ClassModel?; // Extract ClassModel
        if (classItem == null) {
          return const Scaffold(
            body: Center(child: Text("Invalid video data")),
          );
        }
        return VideoScreen(classItem: classItem);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: '/layout',
      builder: (context, state) => const Layout(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const GetStartedView(),
    ),
  ],
);
