import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportSheet extends StatelessWidget {
  const SupportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(PIcons.supportImg, height: 65),
        const SizedBox(height: 12),
        Text(
          'Служба поддержки',
          style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          textAlign: TextAlign.center,
          'Если у вас возникли вопросы или сложности при работе с платформой, вы можете обратиться в службу поддержки.',
          style: TextStyle(color: context.color.textSub),
        ),
        const SizedBox(height: 20),
        ButtonWithScale(
          text: "Написать в поддержку",
          onPressed: () async {
            await launchUrl(Uri.parse("https://t.me/mirodilbekyuldashev"));
          },
          textStyle: TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
