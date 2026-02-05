import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopPartProfile extends StatelessWidget {
  final VoidCallback onTap;
  const TopPartProfile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Профиль', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const Spacer(),
        WScaleAnimation(onTap: onTap, child: SvgPicture.asset(PIcons.editInfoIcon)),
      ],
    );
  }
}
