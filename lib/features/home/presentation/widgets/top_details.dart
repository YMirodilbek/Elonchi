import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopDetailsHome extends StatelessWidget {
  final String adress;
  final VoidCallback onLikedTap;
  final VoidCallback onHotSalesTap;
  const TopDetailsHome({super.key, required this.adress, required this.onLikedTap, required this.onHotSalesTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SvgPicture.asset(PIcons.locationIcon),
          const SizedBox(width: 4),
          Text(adress),
          const Spacer(),
          WScaleAnimation(onTap: onHotSalesTap, child: SvgPicture.asset(PIcons.discountIcon)),
          const SizedBox(width: 8),
          WScaleAnimation(onTap: onLikedTap, child: SvgPicture.asset(PIcons.favouriteIcon)),
        ],
      ),
    );
  }
}
