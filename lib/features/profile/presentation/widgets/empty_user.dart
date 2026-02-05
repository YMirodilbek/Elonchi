import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyUser extends StatelessWidget {
  const EmptyUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.color.icon300),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: context.color.background,
            child: SvgPicture.asset(PIcons.userProfileIcon),
          ),
          const SizedBox(height: 8),
          Text(
            "Напишите свой имя",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.base),
          ),
          const SizedBox(height: 4),
          Text("Профель создань 14.01.2026", style: TextStyle(color: context.color.text400, fontSize: 12)),
        ],
      ),
    );
  }
}
