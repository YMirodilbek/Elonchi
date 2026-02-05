import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/splash/presentation/widgets/language_item.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.base200),
                height: 80,
                width: 80,
                child: Image.asset(PIcons.languageIcon),
              ),
              const SizedBox(height: 20),
              Text("choose.lan".tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text("choose.lan_title".tr()),
              const SizedBox(height: 16),
              LanguageItem(
                iconPath: PIcons.uzIcon,
                title: 'O’zbekcha',
                active: context.locale?.languageCode == 'uz',
                onTap: () {
                  context.setLocale(Locale('uz'));
                },
              ),
              const SizedBox(height: 8),
              LanguageItem(
                iconPath: PIcons.ruIcon,
                title: 'Русский',
                active: context.locale?.languageCode == 'ru',
                onTap: () {
                  context.setLocale(Locale('ru'));
                },
              ),
              const Spacer(),
              ButtonWithScale(
                text: "auth.login.continue".tr(),
                onPressed: () {
                  context.go(Routes.home);
                },
                color: context.color.base,
                textStyle: TextStyle(color: context.color.white),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
