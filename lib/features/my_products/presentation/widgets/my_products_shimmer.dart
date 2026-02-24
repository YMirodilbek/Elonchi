import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyProductsShimmer extends StatelessWidget {
  final int itemCount;

  const MyProductsShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1, color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Image placeholder (80x80)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Content placeholders
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 16,
                            width: 100,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Title placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 14,
                            width: 150,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Views placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 12,
                            width: 60,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Button placeholder
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
