import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageDateSeparator extends StatelessWidget {
  final String timestamp;

  const MessageDateSeparator({super.key, required this.timestamp});

  String _formatDate(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (messageDate == today) {
        return 'Today';
      } else if (messageDate == yesterday) {
        return 'Yesterday';
      } else {
        return DateFormat('dd MMM yyyy').format(dateTime);
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          _formatDate(timestamp),
          style: TextStyle(fontSize: 16, color: context.color.textStrong, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
