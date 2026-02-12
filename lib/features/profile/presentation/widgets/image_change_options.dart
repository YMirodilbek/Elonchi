import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/profile/presentation/widgets/user_image_item.dart';
import 'package:flutter/material.dart';

class ImageChangeOptions extends StatelessWidget {
  final void Function(int inxed) onImageSelect;
  final int? selectedImg;
  const ImageChangeOptions({super.key, required this.selectedImg, required this.onImageSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          5,
          (index) => WScaleAnimation(
            onTap: () {
              onImageSelect(index);
            },
            child: UserImageItem(imagePath: 'assets/images/img$index.png', selected: index == (selectedImg ?? 10)),
          ),
        ),
      ),
    );
  }
}
