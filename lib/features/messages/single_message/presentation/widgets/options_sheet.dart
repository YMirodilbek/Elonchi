import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionsSheet extends StatelessWidget {
  final VoidCallback onReportTap;
  final VoidCallback onDeleteTap;
  const OptionsSheet({super.key, required this.onReportTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          WScaleAnimation(
            onTap: onReportTap,
            child: Row(
              children: [
                SvgPicture.asset(PIcons.reportIcon),
                const SizedBox(width: 8),
                Text("chat.report".tr(), style: TextStyle(fontSize: 16, color: context.color.textStrong)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: context.color.stroke),
          const SizedBox(height: 15),
          WScaleAnimation(
            onTap: onDeleteTap,
            child: Row(
              children: [
                SvgPicture.asset(PIcons.deleteIcon, color: context.color.errorColor),
                const SizedBox(width: 8),
                Text("settings.delete".tr(), style: TextStyle(fontSize: 16, color: context.color.errorColor)),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
