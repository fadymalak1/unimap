import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/features/video/views/video_view.dart';
import 'package:unimap/shared/providers.dart';


class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(favoriteListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Locations")),
      body: favoriteList.isEmpty
          ? const Center(child: Text("No favorites added"))
          : ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final classItem = favoriteList[index];

          return ListTile(
            title: Text(classItem.nameEn),
            subtitle: Text(classItem.nameAr),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                ref.read(favoriteListProvider.notifier).toggleFavorite(classItem);
              },
            ),
            onTap: () {
              context.push('/video', extra: classItem);

            },
          );
        },
      ),
    );
  }
}
