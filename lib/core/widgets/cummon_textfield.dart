import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final String hint;
  const CommonTextfield({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.color.bgelevation),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(color: context.color.textSoft),
          ),
        ),
      ),
    );
  }
}
