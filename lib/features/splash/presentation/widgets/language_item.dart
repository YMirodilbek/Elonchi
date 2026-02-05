import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool active;
  final VoidCallback onTap;
  const LanguageItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.base200),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontSize: 16)),
            const Spacer(),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.black,
              child: CircleAvatar(radius: active ? 4 : 10, backgroundColor: context.color.white),
            ),
          ],
        ),
      ),
    );
  }
}
