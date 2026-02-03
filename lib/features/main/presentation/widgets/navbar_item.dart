import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';

class NavbarItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;
  final String iconPath;
  final double padding;

  const NavbarItem({
    super.key,
    required this.active,
    required this.onTap,
    required this.iconPath,
    this.padding = 24,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Color targetColor = active ? context.color.base : const Color(0xff71717A);
    return WScaleAnimation(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                iconPath,
                key: ValueKey<bool>(active),
                colorFilter: ColorFilter.mode(targetColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: active
                  ? CircleAvatar(key: const ValueKey('active'), radius: 3, backgroundColor: context.color.base)
                  : const SizedBox(key: ValueKey('inactive'), height: 6),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(color: targetColor),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
