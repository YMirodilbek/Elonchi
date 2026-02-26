import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessagesAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool deleting;
  final VoidCallback onTap;
  const MessagesAppbar({super.key, required this.deleting, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        const SizedBox(width: 16),
        Text(
          "nav.messages".tr(),
          style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        WScaleAnimation(
          onTap: onTap,
          child: SvgPicture.asset(PIcons.deleteIcon, color: deleting ? context.color.errorColor : null),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
