import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imagePath;
  const CategoryItem({super.key, required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.bgelevation),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              memCacheHeight: 150,
              memCacheWidth: 150,
              maxHeightDiskCache: 300,
              maxWidthDiskCache: 300,
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              placeholderFadeInDuration: Duration.zero,
              placeholder: (context, url) => const SizedBox.shrink(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          Text(title, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
