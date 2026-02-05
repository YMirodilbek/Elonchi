import 'package:easy_localization/easy_localization.dart';
import 'package:elonchi/app.dart';
import 'package:elonchi/core/models/language_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: List.generate(languages.length, (index) {
        return Locale(languages[index].code);
      }),
      path: 'assets/locale',
      fallbackLocale: const Locale('ru', 'RU'),
      startLocale: const Locale('ru', 'RU'),
      child: const App(),
    ),
  );
}
