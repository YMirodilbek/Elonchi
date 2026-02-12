import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlatformInfoSheet extends StatelessWidget {
  const PlatformInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(PIcons.platformInfoImg, height: 65),
        const SizedBox(height: 12),
        Text(
          'О платформе',
          style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          textAlign: TextAlign.center,
          'Платформа предназначена для безопасной и удобной торговли сырьём, пряжей и текстильной продукцией между покупателями и продавцами.  Мы помогаем находить надёжных партнёров, публиковать товары и напрямую связываться для обсуждения условий сделки. ',
          style: TextStyle(color: context.color.textSub),
        ),
        const SizedBox(height: 20),
        ButtonWithScale(
          text: "Закрыть",
          onPressed: () {
            context.pop();
          },
          textStyle: TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
