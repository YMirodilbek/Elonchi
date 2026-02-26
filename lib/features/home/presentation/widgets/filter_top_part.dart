import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterTopPart extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onResetTap;
  const FilterTopPart({super.key, required this.onBackTap, required this.onResetTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WScaleAnimation(
          onTap: onBackTap,
          child: SvgPicture.asset(PIcons.arrowLeftIcon, color: context.color.iconStrong),
        ),
        const Spacer(),
        const SizedBox(width: 30),
        Text(
          "filter.title".tr(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
        ),
        const Spacer(),
        WScaleAnimation(
          onTap: onResetTap,
          child: Text("filter.clear".tr(), style: TextStyle(color: context.color.textSoft)),
        ),
      ],
    );
  }
}
