import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/home/presentation/widgets/empty_state.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WScaleAnimation(
          onTap: () {
            context.pop();
          },
          child: Padding(padding: const EdgeInsets.all(11.0), child: SvgPicture.asset(PIcons.arrowLeftIcon)),
        ),
        title: Text(
          'Мои желания',
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const LikedEmptyState(),
          const SizedBox(height: 24),
          Text(
            'Рекомендуем',
            style: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ProductItem(
                  productImagePath: "assets/images/item_1.png",
                  title: "500 000 сум",
                  liked: false,
                  description: "Apple magic mishka",
                ),
              ),
              Expanded(
                child: ProductItem(
                  productImagePath: "assets/images/item_2.png",
                  title: "1 200 000 сум",
                  liked: false,
                  description: "Magnitlik Shaxmat",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ProductItem(
                  productImagePath: "assets/images/item_1.png",
                  title: "500 000 сум",
                  liked: false,
                  description: "Apple magic mishka",
                ),
              ),
              Expanded(
                child: ProductItem(
                  productImagePath: "assets/images/item_2.png",
                  title: "1 200 000 сум",
                  liked: false,
                  description: "Magnitlik Shaxmat",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
