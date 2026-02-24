import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserMessageContainer extends StatelessWidget {
  final String? imageUrl;
  const UserMessageContainer({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(12)),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(padding: const EdgeInsets.all(8), child: SvgPicture.asset(PIcons.userSquare)),
                errorWidget: (context, url, error) =>
                    Container(padding: const EdgeInsets.all(8), child: SvgPicture.asset(PIcons.userSquare)),
              ),
            )
          : Padding(padding: const EdgeInsets.all(8), child: SvgPicture.asset(PIcons.userSquare)),
    );
  }
}
