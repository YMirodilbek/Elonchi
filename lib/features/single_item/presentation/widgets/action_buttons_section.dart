import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';

class ActionButtonsSection extends StatelessWidget {
  final VoidCallback? onMessage;
  final VoidCallback? onCall;

  const ActionButtonsSection({super.key, this.onMessage, this.onCall});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWithScale(
            onPressed: onMessage,
            text: "Написать",
            color: context.color.base,
            textStyle: TextStyle(color: context.color.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ButtonWithScale(
            text: "Позвонить",
            onPressed: onCall,
            textStyle: TextStyle(color: context.color.textSub),
            color: context.color.white,
            borderColor: context.color.stroke,
          ),
        ),
      ],
    );
  }
}
