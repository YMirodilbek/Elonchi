import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WatchSheet extends StatelessWidget {
  final bool iswatching;
  const WatchSheet({super.key, required this.iswatching});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/empty_archive.png', height: 67),
        const SizedBox(height: 20),
        Text(
          'Отслеживать цену',
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text('Мы уведомим вас, если цена снизится', style: TextStyle(color: context.color.textSub)),
        const SizedBox(height: 16),
        ButtonWithScale(
          color: iswatching ? context.color.errorColor.withOpacity(0.1) : context.color.base,
          onPressed: () {
            context.pop(true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                PIcons.discountIcon,
                color: !iswatching ? context.color.white : context.color.errorColor,
              ),
              const SizedBox(width: 4),
              Text(
                iswatching ? "Отменить отслеживание" : 'Отслеживать цену',
                style: TextStyle(color: iswatching ? context.color.errorColor : context.color.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
