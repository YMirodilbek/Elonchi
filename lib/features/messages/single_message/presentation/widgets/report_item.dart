import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool active;
  final String description;
  const ReportItem({
    super.key,
    required this.title,
    required this.active,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, color: context.color.textStrong)),
              const SizedBox(height: 2),
              Text(description, style: TextStyle(fontSize: 12, color: context.color.textSoft)),
            ],
          ),
          const Spacer(),
          CustomRadio(active: active),
        ],
      ),
    );
  }
}
