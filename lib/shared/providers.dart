// TODO: Implement shared/providers.dart

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/auth/controller.dart';
import 'package:unimap/features/auth/model.dart';
import 'package:unimap/features/auth/repository.dart';
import 'package:unimap/features/home/controller.dart';
import 'package:unimap/features/home/model.dart';
import 'package:unimap/features/home/repository.dart';
import 'package:unimap/router.dart';
import 'package:unimap/shared/utils.dart';

final appRouterProvider = Provider((ref) => router);

final themeProvider = StateProvider((ref) => AppTheme.light);

final loadingProvider = StateProvider((ref) => false);

final infoDialogProvider = Provider((ref) => showInfoDialog);
final successDialogProvider = Provider((ref) => showSuccessDialog);
final warningDialogProvider = Provider((ref) => showWarningDialog);
final errorDialogProvider = Provider((ref) => showErrorDialog);

final infoToastProvider = Provider((ref) => showInfoToast);
final successToastProvider = Provider((ref) => showSuccessToast);
final errorToastProvider = Provider((ref) => showErrorToast);
final warningToastProvider = Provider((ref) => showWarningToast);


final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(ref.read(authRepositoryProvider)),
);

// Firebase Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});


final userProvider = Provider<UserModel?>((ref) {
  return ref.watch(authControllerProvider).currentUser;
});


final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

final persistentTabControllerProvider = Provider<PersistentTabController>((ref) {
  return PersistentTabController(initialIndex: 0);
});


final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString('locale');
    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    state = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.languageCode);
  }
}

final classRepositoryProvider = Provider<ClassRepository>((ref) => ClassRepository());

final classListProvider = StateNotifierProvider<ClassController, List<ClassModel>>((ref) {
  return ClassController(ref.read(classRepositoryProvider));
});

final favoriteListProvider = StateNotifierProvider<FavoriteController, List<ClassModel>>((ref) {
  return FavoriteController(ref.read(classRepositoryProvider));
});