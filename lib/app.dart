import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elonchi/core/theme/themes.dart';
import 'package:elonchi/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Elonchi',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
