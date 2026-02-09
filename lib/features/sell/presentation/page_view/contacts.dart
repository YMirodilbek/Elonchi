import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class ContancsForm extends StatelessWidget {
  const ContancsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Контакты для связи', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Выберите удобные способы связи с покупателями', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
