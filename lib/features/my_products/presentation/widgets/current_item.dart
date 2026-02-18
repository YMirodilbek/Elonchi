import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentItem extends StatelessWidget {
  final ProductResponse product;
  final VoidCallback onLowerPriceTap;

  const CurrentItem({super.key, required this.product, required this.onLowerPriceTap});

  @override
  Widget build(BuildContext context) {
    final imagePath = product.image?[0].image ?? '';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: context.color.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: CachedNetworkImage(
                  imageUrl: '${PConstants.baseUrl}$imagePath',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.price ?? ""} ${product.moneyType ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (product.title ?? ""),
                    style: TextStyle(fontWeight: FontWeight.w400, color: context.color.textSub),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SvgPicture.asset(PIcons.viewIcon),
                      const SizedBox(width: 4),
                      Text(
                        ": ${product.viewsCount}",
                        style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ButtonWithScale(
            onPressed: onLowerPriceTap,
            text: 'Снизить цену',
            textStyle: TextStyle(fontSize: 14, color: context.color.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
