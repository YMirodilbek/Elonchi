import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NameInput extends StatelessWidget {
  final void Function(String value) onChanged;

  final String userName;
  const NameInput({super.key, required this.userName, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.color.base200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ваше имя', style: TextStyle(color: context.color.textSoft, fontSize: 12)),
                TextField(
                  onChanged: onChanged,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: context.color.textStrong),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(PIcons.arrowRightIcon),
        ],
      ),
    );
  }
}
