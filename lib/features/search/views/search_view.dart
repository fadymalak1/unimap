import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/home/model.dart';
import 'package:unimap/features/video/views/video_view.dart';
import 'package:unimap/shared/providers.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classList = ref.read(classListProvider); // Watch classes
    final favorites = ref.watch(favoriteListProvider); // Watch favorites
    final translate = AppLocalizations.of(context)!.translate;
    final locale = ref.watch(localeProvider);
    bool isArabic = locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Locations"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 14), // Slightly smaller font size
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal.shade50, // Light background
                prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20), // Smaller icon
                hintText: "Search for a class",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14), // Smaller hint text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Slightly smaller radius
                  borderSide: BorderSide(color: Colors.teal, width: 1.5), // Thinner border
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduce padding
              ),
              onChanged: (value) {
                ref.read(classListProvider.notifier).searchClasses(value);
              },
            ),


            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: classList.length,
                itemBuilder: (context, index) {
                  final classItem = classList[index];

                  // Check if this item is in the favorites list
                  bool isFavorite = favorites.any((fav) => fav.id == classItem.id);

                  return GestureDetector(
                    onTap: () {
                      context.push('/video', extra: classItem);
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.slow_motion_video, size: 30, color: AppTheme.primaryColor),
                            const SizedBox(width: 10),
                            isArabic
                                ? Text(classItem.nameAr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                                : Text(classItem.nameEn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.bookmark : Icons.bookmark_border_rounded,
                                color: AppTheme.primaryColor,
                              ),
                              onPressed: () {
                                ref.read(favoriteListProvider.notifier).toggleFavorite(classItem);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
