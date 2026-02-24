import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/core/widgets/user_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ConversationAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? imageUrl;
  final VoidCallback onCallTap;
  final VoidCallback onThreeDotsTap;
  const ConversationAppbar({
    super.key,
    required this.userName,
    required this.onCallTap,
    required this.onThreeDotsTap,
    this.imageUrl,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: SvgPicture.asset(PIcons.arrowLeftIcon),
                ),
                const SizedBox(width: 4),
                UserMessageContainer(imageUrl: imageUrl),
                const SizedBox(width: 8),
                Text(userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const Spacer(),
                WScaleAnimation(onTap: onCallTap, child: SvgPicture.asset(PIcons.callIcon)),
                const SizedBox(width: 17),
                WScaleAnimation(onTap: onThreeDotsTap, child: SvgPicture.asset(PIcons.threeDots)),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
