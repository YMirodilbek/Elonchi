import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/core/widgets/user_message_container.dart';
import 'package:elonchi/features/messages/all_messages/data/chat_list_response.dart';
import 'package:flutter/material.dart';

class MessageStartItem extends StatelessWidget {
  final ChatRoomResponse chatRoom;
  final bool deleting;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const MessageStartItem({
    super.key,
    required this.chatRoom,
    required this.deleting,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final userName = '${chatRoom.user?.firstName ?? ''} ${chatRoom.user?.lastName ?? ''}'.trim();

    // Extract time from timestamp (HH:MM format)
    String getFormattedTime(String? timestamp) {
      if (timestamp == null || timestamp.isEmpty) return '';
      try {
        final dateTime = DateTime.parse(timestamp);
        return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } catch (e) {
        return '';
      }
    }

    final formattedTime = getFormattedTime(chatRoom.lastMessage?.timestamp);

    return WScaleAnimation(
      onTap: deleting ? onDelete : onTap,
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
                  UserMessageContainer(imageUrl: chatRoom.user?.image),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName.isEmpty ? 'Unknown User' : userName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
                      ),
                      Text(
                        chatRoom.product?.title ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: context.color.textSub),
                      ),
                      Text(chatRoom.lastMessage?.content ?? '', style: TextStyle(color: context.color.textSoft)),
                    ],
                  ),
                  const Spacer(),
                  Text(formattedTime, style: TextStyle(color: context.color.textSoft)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
