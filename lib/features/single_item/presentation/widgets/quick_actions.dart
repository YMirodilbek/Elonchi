import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final void Function(String value) onTap;
  const QuickActions({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _QuickActionChip(
            label: 'Торг уместен',
            onTap: () {
              onTap('Торг уместен');
            },
          ),
          const SizedBox(width: 8),
          _QuickActionChip(
            label: 'Хочу купить',
            onTap: () {
              onTap('Хочу купить');
            },
          ),
          const SizedBox(width: 8),
          _QuickActionChip(
            label: 'Доставка есть?',
            onTap: () {
              onTap('Доставка есть?');
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _QuickActionChip({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
