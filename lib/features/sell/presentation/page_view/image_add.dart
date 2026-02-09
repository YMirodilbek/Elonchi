import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAddForm extends StatelessWidget {
  const ImageAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Добавьте фото объявления', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Загрузите от 1 до 6 фотографий. Первое фото будет отображаться в списке товаров.',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 8),
          Text(
            'Формат: JPG или PNG\nМаксимальный размер одного фото — до 10 МБ',
            style: TextStyle(color: context.color.textSoft, fontSize: 12),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 29),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 8, color: context.color.bgelevation),
              borderRadius: BorderRadius.circular(16),
            ),
            child: WScaleAnimation(
              onTap: () {},
              child: Column(
                children: [
                  SvgPicture.asset(PIcons.addring),
                  const SizedBox(height: 4),
                  Text(
                    "Загрузить",
                    style: TextStyle(color: context.color.textStrong, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
