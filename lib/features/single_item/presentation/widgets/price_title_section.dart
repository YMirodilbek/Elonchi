import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PriceTitleSection extends StatelessWidget {
  final VoidCallback onTap;
  final bool isWatching;
  final bool isFree;
  final String? price;
  final String title;
  final bool canNegotiate;

  const PriceTitleSection({
    super.key,
    this.isFree = false,
    this.price,
    required this.title,
    this.canNegotiate = false,
    required this.onTap,
    required this.isWatching,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Text(price!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))],
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 16, color: context.color.textSub)),
        const SizedBox(height: 8),
        WScaleAnimation(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                isWatching ? "Вы уже отслеживаете цену" : 'Отслеживать цену',
                style: TextStyle(color: context.color.base, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset("assets/icons/checkmark-badge-02.svg"),
            ],
          ),
        ),
      ],
    );
  }
}
