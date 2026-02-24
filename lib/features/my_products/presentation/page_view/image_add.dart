import 'dart:io';

import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/my_products/presentation/widgets/added_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAddForm extends StatelessWidget {
  final List<File>? images;
  final VoidCallback onImagetap;
  final void Function(int)? onDeleteImage;
  const ImageAddForm({super.key, required this.onImagetap, this.images, this.onDeleteImage});

  @override
  Widget build(BuildContext context) {
    final bool hasImages = images != null && images!.isNotEmpty;
    final int imageCount = images?.length ?? 0;
    final bool canAddMore = imageCount < 9;
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
            padding: EdgeInsets.symmetric(vertical: hasImages ? 2 : 29),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 8, color: context.color.bgelevation),
              borderRadius: BorderRadius.circular(16),
            ),
            child: hasImages
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemCount: canAddMore ? imageCount : imageCount,
                    itemBuilder: (context, index) {
                      // Show image
                      return AddedImage(image: images![index], onTap: () => onDeleteImage?.call(index));
                    },
                  )
                : WScaleAnimation(
                    onTap: onImagetap,
                    child: Column(
                      children: [
                        SvgPicture.asset(PIcons.addring, color: context.color.iconStrong),
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
