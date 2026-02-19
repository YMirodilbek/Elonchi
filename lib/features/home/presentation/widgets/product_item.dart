import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  final VoidCallback onLikedTap;
  final String productImagePath;
  final String description;
  final String title;
  final bool liked;
  const ProductItem({
    super.key,
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
        context.push(Routes.singleItemScreen);
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
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(color: Colors.grey[300]),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
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
                GestureDetector(onTap: onLikedTap, child: SvgPicture.asset(PIcons.favouriteIcon)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
