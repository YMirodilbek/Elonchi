import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class LikedEmptyState extends StatelessWidget {
  const LikedEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(PIcons.likedImg, height: 98),
          const SizedBox(height: 8),
          Text("Здесь пока пусто", style: TextStyle(color: context.color.textStrong, fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            "Сохраняйте товары, которые вам нравятся,  и мы соберём их здесь для вас",
            textAlign: TextAlign.center,
            style: TextStyle(color: context.color.textSub),
          ),
        ],
      ),
    );
  }
}
