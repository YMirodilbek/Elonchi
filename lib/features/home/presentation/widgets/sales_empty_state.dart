import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class SalesEmptyState extends StatelessWidget {
  const SalesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(PIcons.salesImg, height: 98),
          const SizedBox(height: 8),
          Text("home.watch.product".tr(), style: TextStyle(color: context.color.textStrong, fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            "watch.empty.title".tr(),
            textAlign: TextAlign.center,
            style: TextStyle(color: context.color.textSub),
          ),
        ],
      ),
    );
  }
}
