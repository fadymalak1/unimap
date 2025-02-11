// TODO: Implement app.dart

import 'package:flutter/material.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // themeMode: ,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
