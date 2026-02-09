import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool active;
  const CustomRadio({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.black,
      child: CircleAvatar(radius: active ? 4 : 10, backgroundColor: context.color.white),
    );
  }
}
