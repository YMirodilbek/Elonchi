import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/splash/presentation/widgets/language_item.dart';
import 'package:flutter/material.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(PIcons.choseLangImg, height: 65),
        const SizedBox(height: 12),
        Text(
          "settings.app_language".tr(),
          style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text("settings.choose_language".tr(), style: TextStyle(color: context.color.textSub)),
        const SizedBox(height: 20),
        LanguageItem(
          color: context.color.background,
          iconPath: PIcons.uzIcon,
          title: 'O’zbekcha',
          active: context.locale?.languageCode == 'uz',
          onTap: () {
            context.setLocale(Locale('uz'));
          },
        ),
        const SizedBox(height: 8),
        LanguageItem(
          color: context.color.background,
          iconPath: PIcons.ruIcon,
          title: 'Русский',
          active: context.locale?.languageCode == 'ru',
          onTap: () {
            context.setLocale(Locale('ru'));
          },
        ),
      ],
    );
  }
}
