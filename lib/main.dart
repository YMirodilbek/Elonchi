import 'package:easy_localization/easy_localization.dart';
import 'package:elonchi/app.dart';
import 'package:elonchi/core/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'injector_container.dart' as di;

DateSymbols? symbols = dateTimeSymbolMap()["uz"];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  await initializeDateFormatting(di.localSource.locale);
  symbols = dateTimeSymbolMap()[di.localSource.locale];
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
