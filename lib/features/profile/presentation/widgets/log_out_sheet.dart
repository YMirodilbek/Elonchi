import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogOutSheet extends StatelessWidget {
  const LogOutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/log_out_img.png', height: 66),
        const SizedBox(height: 12),
        Text(
          'Выйти из аккаунта?',
          style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(
          'Вы сможете войти снова в любое время',
          style: TextStyle(color: context.color.textSub, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ButtonWithScale(
                textStyle: TextStyle(color: context.color.white),
                text: 'Выйти',
                onPressed: () {
                  context.pop(true);
                },
                color: context.color.errorColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ButtonWithScale(
                textStyle: TextStyle(color: context.color.textSoft),
                text: 'Назад',
                onPressed: () {
                  context.pop();
                },
                color: context.color.bgelevation,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
