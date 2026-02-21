import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductImageHeader extends StatefulWidget {
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
  State<ProductImageHeader> createState() => _ProductImageHeaderState();
}

class _ProductImageHeaderState extends State<ProductImageHeader> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentImageIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: WScaleAnimation(onTap: widget.onBack, child: SvgPicture.asset(PIcons.arrowLeftIcon)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: WScaleAnimation(
            onTap: widget.onFavoriteToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset(
                widget.isFavorite ? "assets/icons/favourite_filled.svg" : PIcons.favouriteProfileIcon,
                color: widget.isFavorite ? context.color.errorColor : context.color.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: WScaleAnimation(
            onTap: widget.onInfo,
            child: SizedBox(width: 24, height: 24, child: SvgPicture.asset(PIcons.reportIcon)),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Product Image PageView
            widget.images.isNotEmpty
                ? PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[200]),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/dummy_img2.png', fit: BoxFit.contain),
                        ),
                      );
                    },
                  )
                : Center(child: Image.asset('assets/images/dummy_img2.png', fit: BoxFit.contain)),
            // Image indicator dots
            if (widget.images.length > 1)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == _currentIndex ? 40 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == _currentIndex ? const Color(0xFF00A693) : Colors.grey.shade300,
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
