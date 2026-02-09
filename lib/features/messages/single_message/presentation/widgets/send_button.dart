import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendButton extends StatelessWidget {
  final bool canSend;
  final VoidCallback onTap;
  const SendButton({super.key, required this.onTap, required this.canSend});

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: canSend ? onTap : () {},
      child: Opacity(
        opacity: canSend ? 1 : 0.5,
        child: Container(
          padding: const EdgeInsets.all(11),
          height: 40,
          width: 40,
          child: SvgPicture.asset(PIcons.sendIcon),
        ),
      ),
    );
  }
}
