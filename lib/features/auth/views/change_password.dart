import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/shared/providers.dart';
import 'package:unimap/shared/widgets/custom_elevated_button.dart';
import 'package:unimap/shared/widgets/custom_text_field.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final passwordController = TextEditingController();
    final translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('change_password')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate('change_your_password'),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              prefixIcon: Icons.lock_outline,
              controller: passwordController,
              hintText: translate('new_password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {
                authController.changePassword(passwordController.text, context);
              },
              child: Text(translate('change_password')),
            ),
          ],
        ),
      ),
    );
  }
}
