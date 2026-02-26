import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderTabs extends StatelessWidget {
  final void Function(int value) onChaged;
  final int value;
  const SliderTabs({super.key, required this.value, required this.onChaged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: context.color.bgelevation,
        thumbColor: context.color.base,
        padding: const EdgeInsets.all(5),
        groupValue: value,
        children: {
          0: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            child: Text(
              "messages.buy".tr(),
              style: value == 0
                  ? const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)
                  : TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          1: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  "messages.sell".tr(),
                  style: value == 1
                      ? const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)
                      : TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(width: 8),
                const Spacer(),
              ],
            ),
          ),
        },
        onValueChanged: (value) {
          onChaged(value!);
        },
      ),
    );
  }
}
