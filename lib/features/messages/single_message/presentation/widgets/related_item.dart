import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RelatedItem extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String itemName;
  final String itemPrice;
  const RelatedItem({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.itemPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: SizedBox(height: 44, child: Image.asset("assets/images/dummy_img.png")),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemName, style: TextStyle(fontSize: 16, color: context.color.textStrong)),
                const SizedBox(height: 4),
                Text(itemPrice, style: TextStyle(fontSize: 16, color: context.color.textSoft)),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(PIcons.arrowRightIcon),
          ],
        ),
      ),
    );
  }
}
