import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/shared/providers.dart';
import 'package:unimap/shared/utils.dart';
import 'package:unimap/shared/widgets/custom_elevated_button.dart';
import 'package:unimap/shared/widgets/language_bottom_sheet.dart';
import 'package:unimap/shared/widgets/setting_tile_widget.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);
    final user = authState.currentUser;
    final translation = AppLocalizations.of(context)!.translate;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      translation("profile"),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(AppImages.profile),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.firstName ?? translation("guest"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      user?.email ?? "guest@unimap.com",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translation("settings"),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ProfileTileWidget(
                            icon: Icons.language,
                            title: translation("language"),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                builder: (context) {
                                  return LanguageBottomSheet();
                                },
                              );
                            },
                          ),
                          if (user?.email != null) ...[
                            const SizedBox(height: 20),
                            Text(
                              translation("privacy_security"),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            ProfileTileWidget(
                              icon: Icons.password,
                              title: translation("change_password"),
                              onTap: () {
                                context.push('/change-password');
                              },
                            ),
                            ProfileTileWidget(
                              icon: Icons.remove_circle_outline_rounded,
                              title: translation("delete_account"),
                              onTap: () {
                                authController.deleteAccount(context);
                              },
                            ),
                          ],
                          const SizedBox(height: 20),
                          Text(
                            translation("help_support"),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ProfileTileWidget(
                            icon: Icons.policy_outlined,
                            title: translation("terms_conditions"),
                            onTap: () {},
                          ),
                          ProfileTileWidget(
                            icon: Icons.privacy_tip_outlined,
                            title: translation("privacy_policy"),
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          Text(
                            translation("about_us"),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ProfileTileWidget(
                            icon: Icons.info_outline_rounded,
                            title: translation("about_unimap"),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between widgets and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      authController.logout(context);
                    },
                    child: Text(translation("logout")),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "${translation("version")} 1.0.0",
                      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
