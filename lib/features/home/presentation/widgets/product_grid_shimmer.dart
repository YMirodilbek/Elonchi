import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(height: 8),
              // Title placeholder
              Container(
                width: double.infinity,
                height: 12,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 6),
              // Description placeholder
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 8),
              // Date/Region row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                  ),
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
