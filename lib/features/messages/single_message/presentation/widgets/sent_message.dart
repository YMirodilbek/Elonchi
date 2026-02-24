import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SentMessage extends StatelessWidget {
  final String? imageUrl;

  final String message;
  final bool read;
  final String time;
  const SentMessage({super.key, required this.message, required this.read, required this.time, this.imageUrl});

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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image if exists
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 157,
                    height: 157,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(width: 157, height: 157, color: Colors.grey[300]),
                    errorWidget: (context, url, error) =>
                        Container(width: 157, height: 157, color: Colors.grey[300], child: const Icon(Icons.error)),
                  ),
                ),
              ),
            // Message text
            Text(message, style: TextStyle(color: context.color.textStrong)),
            // Time and read status
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(time, style: TextStyle(color: context.color.textSoft)),
                const SizedBox(width: 4),
                SvgPicture.asset(PIcons.doubleTickICon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
