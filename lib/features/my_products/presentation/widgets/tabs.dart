import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/my_products/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';

class SellTabs extends StatelessWidget {
  const SellTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 16),
          TabItem(title: "sell.active".tr(), active: true),
          TabItem(title: "sell.on_review".tr(), active: false),
          TabItem(title: "sell.drafts".tr(), active: false),
          TabItem(title: "sell.archive".tr(), active: false),
        ],
      ),
    );
  }
}
