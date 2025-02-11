// TODO: Implement shared/providers.dart

import 'package:riverpod/riverpod.dart';
import 'package:unimap/config/themes.dart';
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

