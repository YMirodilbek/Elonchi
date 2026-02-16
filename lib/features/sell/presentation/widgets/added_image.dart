import 'dart:io';

import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddedImage extends StatelessWidget {
  final VoidCallback onTap;
  final File image;
  const AddedImage({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          Image.file(image, fit: BoxFit.cover),

          // Delete button overlay
          Positioned(
            top: 4,
            right: 4,
            child: WScaleAnimation(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                child: SvgPicture.asset(PIcons.deleteImgIcon, height: 20, width: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
