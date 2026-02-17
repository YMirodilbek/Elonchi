import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorySelectItem extends StatelessWidget {
  final CategoryResponse categoryResponse;
  final VoidCallback onCategoryTap;
  const CategorySelectItem({super.key, required this.onCategoryTap, required this.categoryResponse});

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onCategoryTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.bgelevation),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.background),
              child: Image.asset('assets/images/all_categories.png'),
            ),
            const SizedBox(width: 8),
            Text(categoryResponse.name ?? '', style: TextStyle(color: context.color.textStrong)),
            const Spacer(),
            SvgPicture.asset(PIcons.arrowRightIcon),
          ],
        ),
      ),
    );
  }
}
