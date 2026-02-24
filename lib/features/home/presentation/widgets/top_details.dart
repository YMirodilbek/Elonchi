import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopDetailsHome extends StatelessWidget {
  final VoidCallback onLocationTap;
  final String adress;
  final VoidCallback onLikedTap;
  final VoidCallback onHotSalesTap;
  const TopDetailsHome({
    super.key,
    required this.adress,
    required this.onLikedTap,
    required this.onHotSalesTap,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          WScaleAnimation(onTap: onLocationTap, child: SvgPicture.asset(PIcons.locationIcon)),
          const SizedBox(width: 4),
          WScaleAnimation(
            onTap: onLocationTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (adress.isEmpty)
                  Text(
                    'home.select_region'.tr(),
                    style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
                  ),
                Text(adress),
              ],
            ),
          ),
          const Spacer(),
          WScaleAnimation(onTap: onHotSalesTap, child: SvgPicture.asset(PIcons.discountIcon)),
          const SizedBox(width: 8),
          WScaleAnimation(onTap: onLikedTap, child: SvgPicture.asset(PIcons.favouriteIcon)),
        ],
      ),
    );
  }
}
