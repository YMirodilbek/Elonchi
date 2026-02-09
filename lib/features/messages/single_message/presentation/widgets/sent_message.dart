import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SentMessage extends StatelessWidget {
  final String message;
  final bool read;
  final String time;
  const SentMessage({super.key, required this.message, required this.read, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.color.bgelevation,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: TextStyle(color: context.color.textStrong)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(time, style: TextStyle(color: context.color.textSoft)),
                SvgPicture.asset(PIcons.doubleTickICon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
