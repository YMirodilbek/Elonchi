import 'package:elonchi/features/sell/presentation/widgets/tab_item.dart';
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
          TabItem(title: 'Активные', active: true),
          TabItem(title: 'На проверке', active: false),
          TabItem(title: 'Черновики', active: false),
          TabItem(title: 'Архив', active: false),
        ],
      ),
    );
  }
}
