import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProgressBar extends StatelessWidget {
  final double completionProgress;
  final int currentPage;
  final double value;
  final VoidCallback onBackTap;
  const ProgressBar({
    super.key,
    required this.value,
    required this.onBackTap,
    required this.completionProgress,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBackTap,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(PIcons.arrowLeftIcon, color: context.color.iconStrong),
                ),
              ),
              const Spacer(),
              WScaleAnimation(
                onTap: () {
                  context.pop();
                },
                child: Text('Закрыть', style: TextStyle(color: context.color.textSoft)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                '$currentPage/8',
                style: TextStyle(fontSize: 6, fontWeight: FontWeight.w500, color: context.color.textStrong),
              ),
              const Spacer(),
              Text(
                '$completionProgress%',
                style: TextStyle(fontSize: 6, fontWeight: FontWeight.w500, color: context.color.textStrong),
              ),
            ],
          ),
          const SizedBox(height: 2),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(8),
            minHeight: 8,
            value: value,
            color: context.color.base,
            backgroundColor: context.color.bgelevation,
          ),
        ],
      ),
    );
  }
}
