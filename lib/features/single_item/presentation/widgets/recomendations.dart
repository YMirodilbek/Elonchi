import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

class RecomendationsSingle extends StatelessWidget {
  const RecomendationsSingle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Рекомендуем",
            style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
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
