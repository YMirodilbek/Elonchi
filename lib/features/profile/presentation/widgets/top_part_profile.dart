import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopPartProfile extends StatelessWidget {
  final VoidCallback onEditTap;
  const TopPartProfile({super.key, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Профиль', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const Spacer(),
        WScaleAnimation(
          onTap: onEditTap,
          child: SvgPicture.asset(PIcons.editInfoIcon, color: context.color.iconStrong),
        ),
      ],
    );
  }
}
