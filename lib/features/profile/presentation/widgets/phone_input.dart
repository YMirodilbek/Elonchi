import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';

class PhoneInput extends StatelessWidget {
  final String phoneNumber;
  const PhoneInput({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.base200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("profile.phone_number".tr(), style: TextStyle(color: context.color.textSoft, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            phoneNumber,
            style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
