import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elonchi/core/theme/themes.dart';
import 'package:elonchi/core/theme/theme_manager.dart';
import 'package:elonchi/core/theme/theme_provider.dart';
import 'package:elonchi/router/app_routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void dispose() {
    _themeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeManager: _themeManager,
      child: ListenableBuilder(
        listenable: _themeManager,
        builder: (context, _) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Elonchi',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            themeMode: _themeManager.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
