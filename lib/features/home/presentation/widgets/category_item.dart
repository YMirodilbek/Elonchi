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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.icon300),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 2),
          Text(title, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
