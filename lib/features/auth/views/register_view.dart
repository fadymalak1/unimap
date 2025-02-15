import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/auth/controller.dart';
import 'package:unimap/shared/utils.dart';
import 'package:unimap/shared/widgets/custom_text_field.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    final _formKey = GlobalKey<FormState>(); // Form key for validation

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            "UniMap",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey, // Assign the form key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(AppImages.logo, height: 150)),
                      const SizedBox(height: 20),
                      Text(
                        "Register Now!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // First Name TextField
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: "First Name",
                              controller: authController.firstNameController,
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Last Name TextField
                          Expanded(
                            child: CustomTextField(
                              hintText: "Last Name",
                              controller: authController.lastNameController,
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Email TextField
                      CustomTextField(
                        hintText: "Enter your email",
                        prefixIcon: Icons.email_outlined,
                        controller: authController.emailController,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password TextField
                      CustomTextField(
                        hintText: "Enter your password",
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        hasSuffixIcon: true,
                        controller: authController.passwordController,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: authState.isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              authController.register(
                                authController.firstNameController.text,
                                authController.lastNameController.text,
                                authController.emailController.text,
                                authController.passwordController.text,
                                context,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: authState.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Register", style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Option
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () => context.pop("/login"),
                              child: Text("Login", style: TextStyle(color: AppTheme.primaryColor)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}