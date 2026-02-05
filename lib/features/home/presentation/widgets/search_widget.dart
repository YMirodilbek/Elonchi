import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SearchWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: context.color.icon300, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            SvgPicture.asset(PIcons.homeIcon, height: 24),
            const SizedBox(width: 8),
            Text('Поиск товаров', style: TextStyle(color: context.color.text400, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
