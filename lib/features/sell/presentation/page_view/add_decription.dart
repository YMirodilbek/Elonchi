import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class DecriptionsForm extends StatelessWidget {
  final void Function(String value) onChanged;
  const DecriptionsForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Добавьте описание', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Расскажите подробнее о товаре, его состоянии и особенностях',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 32),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: context.color.textSoft),
              hintText: 'Описания товара',
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.color.base200, width: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
