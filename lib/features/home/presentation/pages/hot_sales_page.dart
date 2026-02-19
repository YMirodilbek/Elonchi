import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/home/presentation/widgets/product_item.dart';
import 'package:elonchi/features/home/presentation/widgets/sales_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HotSalesPage extends StatefulWidget {
  const HotSalesPage({super.key});

  @override
  State<HotSalesPage> createState() => _HotSalesPageState();
}

class _HotSalesPageState extends State<HotSalesPage> {
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
          'Отслеживать цену',
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SalesEmptyState(),
          const SizedBox(height: 24),
          Text(
            'Рекомендуем',
            style: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong, fontSize: 16),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
