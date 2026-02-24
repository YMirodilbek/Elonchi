import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchSelectedCategories extends StatelessWidget {
  final VoidCallback onCategoryTap;
  final String? categoryName;
  const SearchSelectedCategories({super.key, this.categoryName = 'Все категории', required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WScaleAnimation(
          onTap: onCategoryTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: context.color.textStrong),
            child: Row(
              children: [
                Text(categoryName ?? 'Все категории', style: TextStyle(color: context.color.background)),
                const SizedBox(width: 8),
                SvgPicture.asset(PIcons.menuIcon, color: context.color.background),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: WScaleAnimation(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: context.color.stroke),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  SvgPicture.asset(PIcons.arrorDown, color: context.color.textSub),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "home.recommended".tr(),
                      style: TextStyle(color: context.color.textSub),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
