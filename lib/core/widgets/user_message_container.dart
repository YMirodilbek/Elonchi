import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserMessageContainer extends StatelessWidget {
  const UserMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(12)),
      child: SvgPicture.asset(PIcons.userSquare),
    );
  }
}
