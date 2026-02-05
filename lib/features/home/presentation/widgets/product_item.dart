import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductItem extends StatelessWidget {
  final String productImagePath;
  final String description;
  final String title;
  final bool liked;
  const ProductItem({
    super.key,
    required this.productImagePath,
    required this.title,
    required this.liked,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(productImagePath)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(fontSize: 12)),
              ],
            ),
            const Spacer(),
            WScaleAnimation(child: SvgPicture.asset(PIcons.favouriteIcon), onTap: () {}),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
