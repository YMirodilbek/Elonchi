import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final String time;
  final String message;
  const ReceivedMessage({super.key, required this.time, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.color.bgelevation,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: TextStyle(color: context.color.textStrong)),
            Text(time, style: TextStyle(color: context.color.textSoft)),
          ],
        ),
      ),
    );
  }
}
