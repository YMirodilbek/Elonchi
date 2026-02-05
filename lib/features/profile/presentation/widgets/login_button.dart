import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonWithScale(
      onPressed: onTap,
      horizontalMargin: 16,
      text: "Войти в систему",
      color: context.color.base,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.white),
    );
  }
}
