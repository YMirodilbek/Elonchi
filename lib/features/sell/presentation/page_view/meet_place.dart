import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class MeetPlaceForm extends StatelessWidget {
  const MeetPlaceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите место встречи', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Покупатель должен понимать, где и как можно получить товар',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
