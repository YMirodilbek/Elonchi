import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Описание',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
        ),
        const SizedBox(height: 8),
        Text(description, style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.5)),
      ],
    );
  }
}
