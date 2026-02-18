import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCategoryForm extends StatelessWidget {
  final String? categoryName;
  final VoidCallback onCategoryTap;
  const SelectCategoryForm({super.key, required this.onCategoryTap, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Выберите категорию', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Выберите подходящую категорию, чтобы покупатели быстрее нашли ваш товар',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 8),
          WScaleAnimation(
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
                  Text(categoryName ?? ' Категория', style: TextStyle(color: context.color.textStrong)),
                  const Spacer(),
                  SvgPicture.asset(PIcons.arrowRightIcon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
