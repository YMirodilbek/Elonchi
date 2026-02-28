import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatelessWidget {
  final int itemId;
  final VoidCallback onLikedTap;
  final String productImagePath;
  final String description;
  final String title;
  final bool liked;
  final DateTime? createdAt;
  final String regionName;

  const ProductItem({
    super.key,
    required this.createdAt,
    required this.regionName,
    required this.itemId,
    required this.onLikedTap,
    required this.productImagePath,
    required this.title,
    required this.liked,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () {
        context.push(Routes.singleItemScreen, extra: itemId);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: productImagePath,
                memCacheHeight: 300,
                memCacheWidth: 300,
                maxHeightDiskCache: 600,
                maxWidthDiskCache: 600,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                placeholder: (context, url) => const SizedBox.shrink(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(description, style: TextStyle(fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onLikedTap,
                child: liked ? SvgPicture.asset(PIcons.likedFilledIcon) : SvgPicture.asset(PIcons.favouriteIcon),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                createdAt != null ? DateFormat('HH:mm dd.MM.yyyy').format(createdAt!) : 'Unknown',
                style: TextStyle(fontSize: 10, color: context.color.textSub),
              ),
              const Spacer(),
              Text(
                regionName,
                style: TextStyle(fontSize: 10, color: context.color.textSub, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
