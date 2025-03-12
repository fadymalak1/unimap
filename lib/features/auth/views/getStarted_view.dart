import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/shared/providers.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/shared/utils.dart';
import 'package:unimap/shared/widgets/custom_elevated_button.dart';

class GetStartedView extends ConsumerWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("🛠️ Building GetStartedView...");

    final authState = ref.watch(authStateProvider);

    authState.when(
      data: (user) {
        if (user != null) {
          Future.microtask(() async {
            print("✅ User found: ${user.email}, navigating to /layout...");
            await ref.read(authControllerProvider.notifier).checkUserSession(context);
            if (context.mounted) context.go('/layout');
          });
        }
      },
      loading: () => print("⏳ Loading user data..."),
      error: (e, _) => print("❌ Auth Error: $e"),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: authState.when(
        loading: () => _buildSplashScreen(), // Show splash while loading
        data: (user) => user != null ? _buildSplashScreen() : _buildGetStartedScreen(context),
        error: (_, __) => _buildGetStartedScreen(context), // Show Get Started screen on error
      ),
    );
  }

  /// 🔥 Splash Screen (While checking auth)
  Widget _buildSplashScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo, width: 150, height: 150),
          const SizedBox(height: 40),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  /// 🏁 Get Started Screen (If user is not logged in)
  Widget _buildGetStartedScreen(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return Column(
      children: [
        Expanded(child: Image.asset(AppImages.background, fit: BoxFit.cover, width: double.infinity)),
        const SizedBox(height: 20),
        Text("UniMap",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppTheme.primaryColor)),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: CustomElevatedButton(
            onPressed: () => GoRouter.of(context).push("/login"),
            child: Text(translate("Get Started")),
          ),
        ),
      ],
    );
  }
}
