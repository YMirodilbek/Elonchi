import 'package:elonchi/core/extension/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final String? imageUrl;
  final String time;
  final String message;
  const ReceivedMessage({super.key, required this.time, required this.message, this.imageUrl});

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
            // Time
            Text(time, style: TextStyle(color: context.color.textSoft)),
          ],
        ),
      ),
    );
  }
}
