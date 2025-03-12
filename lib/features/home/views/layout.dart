import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:unimap/config/app_loalizations.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/favourites/views/favourites_view.dart';
import 'package:unimap/features/profile/views/profile_view.dart';
import 'package:unimap/features/search/views/search_view.dart';
import 'package:unimap/shared/providers.dart';

import 'home_view.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeView(),    // Home Screen
      SearchView(),  // Search Screen
      FavoritesView(), // Favourites Screen
      ProfileView(), // Profile Screen
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final translation = AppLocalizations.of(context)!.translate;

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: translation("home"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: translation("search"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark),
        title: translation("saved"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: translation("profile"),
        activeColorPrimary: AppTheme.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(persistentTabControllerProvider);

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        colorBehindNavBar: Colors.white,
      ),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      backgroundColor: Colors.white,
      isVisible: true,
      confineToSafeArea: true,
      navBarHeight: 70,
      navBarStyle: NavBarStyle.style1,
    );
  }
}
