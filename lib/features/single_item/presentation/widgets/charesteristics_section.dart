import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class CharacteristicsSection extends StatelessWidget {
  final Map<String, String> characteristics;

  const CharacteristicsSection({super.key, required this.characteristics});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Характеристики',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
        ),
        const SizedBox(height: 12),
        ...characteristics.entries.map((entry) => _CharacteristicRow(label: entry.key, value: entry.value)),
      ],
    );
  }
}

class _CharacteristicRow extends StatelessWidget {
  final String label;
  final String value;

  const _CharacteristicRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 15, color: Colors.grey.shade600)),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
