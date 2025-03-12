import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/auth/model.dart';
import 'package:unimap/shared/providers.dart';
import 'package:unimap/shared/utils.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final classList = ref.watch(classListProvider); // Watch classes
    final favorites = ref.watch(favoriteListProvider); // Watch favorites
    final isMorning = DateTime.now().hour < 12;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMorning ? "Good Morning!" : "Good Afternoon!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "${user?.firstName ?? 'Guest'} ${user?.lastName ?? ''}",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        centerTitle: false,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logoTransparent, fit: BoxFit.cover, height: 140),
            const SizedBox(height: 15),

            // **New Description Text**
            const Text(
              "📍 Easily find your way! \n"
                  "Our app helps you quickly locate classrooms, lecture halls, and labs within the faculty.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Search Field
            GestureDetector(
              onTap: () {
                ref.read(persistentTabControllerProvider).jumpToTab(1);
              },
              child: TextField(
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor),
                  hintText: "Search for places",
                  hintStyle: TextStyle(color: AppTheme.primaryColor),
                  enabled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.lightPrimary,
                ),
              ),


            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(persistentTabControllerProvider).jumpToTab(1);
                    },
                    child: Card(
                      elevation: 0.5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Image.asset(AppImages.classs, color: AppTheme.primaryColor, width: 50,),
                            SizedBox(height: 15,),
                            Text("${classList.length} Classes")
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(persistentTabControllerProvider).jumpToTab(2);
                    },
                    child: Card(
                        elevation: 0.5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Image.asset(AppImages.bookmark, color: AppTheme.primaryColor, width: 50,),
                              SizedBox(height: 15,),
                              Text("${favorites.length} Saved")
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
