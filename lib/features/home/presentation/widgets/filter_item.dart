import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterItem extends StatelessWidget {
  final BorderRadiusGeometry borderRadiusGeometry;
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const FilterItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    BorderRadiusGeometry? borderRadiusGeometry,
  }) : borderRadiusGeometry = borderRadiusGeometry ?? const BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadiusGeometry, color: context.color.bgelevation),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, color: context.color.iconStrong),
            const SizedBox(width: 8),
            Text(title),
            const Spacer(),
            SvgPicture.asset(PIcons.arrowRightIcon),
          ],
        ),
      ),
    );
  }
}
