import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class RequirementsForm extends StatelessWidget {
  const RequirementsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите условия сделки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Выберите, как вы хотите продать или отдать товар', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 24),
          Text('Условия', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: context.color.stroke),
                ),
                child: Text('Указать цену', style: TextStyle(color: context.color.textSoft)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: context.color.stroke),
                ),
                child: Text('Обмен         ', style: TextStyle(color: context.color.textSoft)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: context.color.stroke),
                ),
                child: Text('Отдам даром', style: TextStyle(color: context.color.textSoft)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
