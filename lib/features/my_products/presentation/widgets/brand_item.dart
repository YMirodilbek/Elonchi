import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrandItem extends StatelessWidget {
  final String brand;
  final bool selected;
  const BrandItem({super.key, required this.brand, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: 15, horizontal: 8),
      child: Row(
        children: [
          Text(brand, style: TextStyle(color: context.color.textStrong)),
          const Spacer(),
          selected
              ? SvgPicture.asset(PIcons.selectedIcon)
              : Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.color.bgelevation,
                    border: Border.all(width: 2, color: context.color.bgElevattion2),
                    borderRadius: .circular(8),
                  ),
                ),
        ],
      ),
    );
  }
}
