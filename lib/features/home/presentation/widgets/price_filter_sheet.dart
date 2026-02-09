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
              Text('По умолчанию', style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: true),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text('Сначала новые', style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text('Дешевле', style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text('Дороже', style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text('Популярные', style: TextStyle(color: context.color.textStrong)),
              const Spacer(),
              CustomRadio(active: false),
            ],
          ),
        ],
      ),
    );
  }
}
