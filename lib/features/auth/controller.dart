import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/features/auth/repository.dart';
import 'package:unimap/features/auth/model.dart';
import 'package:unimap/shared/utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(ref.read(authRepositoryProvider)),
);

// Firebase Auth State Provider
final authStateProvider = StreamProvider<User?>(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  AuthController(this.authRepository) : super(AuthState());

  Future<void> login(String email, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await authRepository.login(email, password);

    result.fold(
          (error) => showErrorToast(error),
          (user) {
        state = state.copyWith(currentUser: user);
        context.go('/home');
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> register(String firstName, String lastName, String email, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await authRepository.register(firstName, lastName, email, password);

    result.fold(
          (error) => showErrorToast(error),
          (user) {
        state = state.copyWith(currentUser: user);
        context.go('/home');
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> checkUserSession(BuildContext context) async {
    final result = await authRepository.getCurrentUser();

    result.fold(
          (error) {
        if (context.mounted) {
          GoRouter.of(context).go('/login');
        }
      },
          (user) {
        state = state.copyWith(currentUser: user);
        if (context.mounted) {
          GoRouter.of(context).go('/home');
        }
      },
    );
  }
}

class AuthState {
  final bool isLoading;
  final UserModel? currentUser;

  AuthState({this.isLoading = false, this.currentUser});

  AuthState copyWith({bool? isLoading, UserModel? currentUser}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
