import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class AddNameForm extends StatelessWidget {
  final FocusNode? focusNode;
  final void Function(String title) onChanged;
  const AddNameForm({super.key, required this.onChanged, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите название товара', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Короткое и понятное название поможет быстрее найти ваше объявление',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 32),
          TextField(
            focusNode: focusNode,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: context.color.textSoft),
              hintText: 'Название товара',
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.color.base200, width: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
