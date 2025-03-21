import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/auth/repository.dart';
import 'package:unimap/features/auth/model.dart';
import 'package:unimap/shared/utils.dart';

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
        context.go('/layout');
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> logout(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final translate=AppLocalizations.of(context)!.translate;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center( // Center the title
            child: Text(
              translate("Are you sure you want to logout?"),
              textAlign: TextAlign.center, // Ensure text is centered
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: AppTheme.primaryColor),
                      ),

                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(translate("Cancel")),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      await authRepository.logout().then(
                              (value) {
                            state = state.copyWith(currentUser: null);
                            state = state.copyWith(isLoading: false);
                            context.go('/login');
                          });
                    },
                    child: Text(translate("Logout")),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    state = state.copyWith(isLoading: false);
  }


  Future<void> deleteAccount(BuildContext context) async {
    final translate = AppLocalizations.of(context)!.translate;
    state = state.copyWith(isLoading: true);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center( // Center the title
            child: Text(
              translate('Are you sure you want to delete your account?'),
              textAlign: TextAlign.center, // Ensure text is centered
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: AppTheme.primaryColor),
                      ),

                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(translate('Cancel')),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      await authRepository.deleteAccount().then((value) {
                        state = state.copyWith(currentUser: null);
                        state = state.copyWith(isLoading: false);
                        context.go('/login');
                      });
                    },
                    child: Text(translate('Delete')),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> changePassword(String newPassword, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    await authRepository.changePassword(newPassword);
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
    print("🔍 Checking user session...");

    final result = await authRepository.getCurrentUser();

    result.fold(
          (error) {
        print("❌ No user session found: $error");
        if (context.mounted) {
          GoRouter.of(context).go('/'); // Redirect to login if session is invalid
        }
      },
          (user) {
        print("✅ User session found: ${user.email}");
        state = state.copyWith(currentUser: user);
        if (context.mounted) {
          GoRouter.of(context).go('/layout'); // Redirect to main layout
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
