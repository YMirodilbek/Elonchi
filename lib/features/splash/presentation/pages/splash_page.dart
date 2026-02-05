import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/splash/presentation/widgets/logo_withtext.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:elonchi/router/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Alignment _alignment = Alignment.center;
  double _offsetX = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _alignment = Alignment.centerLeft;
        _offsetX = -1000; // Move far left
      });

      Future.delayed(const Duration(milliseconds: 400), () {
        if (context.mounted) {
          context.go(Routes.languageScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.base,
      body: AnimatedAlign(
        alignment: _alignment,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: AnimatedSlide(
          offset: Offset(_offsetX / MediaQuery.of(context).size.width, 0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: const LogoWithtext(),
        ),
      ),
    );
  }
}
