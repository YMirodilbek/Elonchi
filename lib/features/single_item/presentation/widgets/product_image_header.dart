import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductImageHeader extends StatelessWidget {
  final bool isFavorite;
  final int currentImageIndex;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onBack;
  final VoidCallback onInfo;
  final List<String> images;

  const ProductImageHeader({
    super.key,
    required this.isFavorite,
    required this.currentImageIndex,
    required this.onFavoriteToggle,
    required this.onBack,
    required this.onInfo,
    this.images = const ['assets/images/dummy_img2.png', 'assets/images/dummy_img2.png'],
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: WScaleAnimation(onTap: onBack, child: SvgPicture.asset(PIcons.arrowLeftIcon)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: WScaleAnimation(
            onTap: onFavoriteToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: SvgPicture.asset(PIcons.favouriteProfileIcon, color: context.color.errorColor),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: WScaleAnimation(
            onTap: onInfo,
            child: SizedBox(width: 24, height: 24, child: SvgPicture.asset(PIcons.reportIcon)),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Product Image
            Center(child: Image.asset(images.first, fit: BoxFit.contain)),
            // Image indicator dots
            if (images.length > 1)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == currentImageIndex ? 40 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == currentImageIndex ? const Color(0xFF00A693) : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
