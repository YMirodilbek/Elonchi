import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCategoryForm extends StatelessWidget {
  const SelectCategoryForm({super.key});

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
        ],
      ),
    );
  }
}
