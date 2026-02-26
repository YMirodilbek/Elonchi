import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

class PriceFilterSheet extends StatelessWidget {
  const PriceFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text("filter.default".tr(), style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: true),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text("filter.newer".tr(), style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text("filter.cheaper".tr(), style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text("filter.expensive".tr(), style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text("filter.popular".tr(), style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
        ],
      ),
    );
  }
}
