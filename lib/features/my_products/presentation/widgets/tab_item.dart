import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool active;
  const TabItem({super.key, required this.title, required this.active});

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? context.color.bgelevation : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: context.color.stroke),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: active ? context.color.textStrong : context.color.textSoft,
          ),
        ),
      ),
    );
  }
}
