import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/core/widgets/user_message_container.dart';
import 'package:flutter/material.dart';

class MessageStartItem extends StatelessWidget {
  final bool deleting;
  final VoidCallback onTap;
  final String userName;
  final String itemName;
  final String lastMessage;
  final String time;
  const MessageStartItem({
    super.key,
    required this.deleting,
    required this.userName,
    required this.itemName,
    required this.lastMessage,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onTap,
      child: Row(
        children: [
          if (deleting)
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: context.color.stroke),
                borderRadius: BorderRadius.circular(8),
                color: context.color.background,
              ),
            ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 0.5, color: context.color.stroke),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserMessageContainer(),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
                      ),
                      Text(
                        itemName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textSub),
                      ),
                      Text(lastMessage, style: TextStyle(color: context.color.textSoft)),
                    ],
                  ),
                  const Spacer(),
                  Text(time, style: TextStyle(color: context.color.textSoft)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
