import 'package:flutter/material.dart';
import 'package:elonchi/core/theme/themes.dart';
import 'package:elonchi/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Elonchi',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
