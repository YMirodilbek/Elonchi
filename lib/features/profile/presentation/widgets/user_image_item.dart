import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class UserImageItem extends StatelessWidget {
  final bool selected;
  final String imagePath;
  const UserImageItem({super.key, required this.imagePath, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      padding: const EdgeInsets.only(top: 4, left: 6, right: 6, bottom: 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: context.color.bgelevation),
      child: Image.asset(imagePath),
    );
  }
}
