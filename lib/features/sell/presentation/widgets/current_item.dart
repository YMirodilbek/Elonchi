import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentItem extends StatelessWidget {
  final VoidCallback onLowerPriceTap;
  final String imagePath;
  final String itemPrice;
  final String itemName;
  final int watchedCount;
  const CurrentItem({
    super.key,
    required this.onLowerPriceTap,
    required this.imagePath,
    required this.itemPrice,
    required this.itemName,
    required this.watchedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: context.color.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadiusGeometry.circular(16), child: Image.asset(imagePath, height: 80)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemPrice,
                    style: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    itemName,
                    style: TextStyle(fontWeight: FontWeight.w400, color: context.color.textSub),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SvgPicture.asset(PIcons.viewIcon),
                      const SizedBox(width: 4),
                      Text(
                        ": $watchedCount",
                        style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ButtonWithScale(
            onPressed: onLowerPriceTap,
            text: 'Снизить цену',
            textStyle: TextStyle(fontSize: 14, color: context.color.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
