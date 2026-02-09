import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class ParametsForm extends StatelessWidget {
  const ParametsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите характеристики', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Это поможет покупателям лучше понять ваш товар', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 24),
          Text('Состояние', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                  ),
                  child: Text('Новый', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                  ),
                  child: Text('Б/у         ', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                  ),
                  child: Text('Как новый', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Бренд', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
