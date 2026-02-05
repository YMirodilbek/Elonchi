import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/utils/imports.dart';
import 'package:flutter/material.dart';

import '../../router/app_routes.dart';

Future<T?> triggerBottomSheet<T>({
  required Widget content,
  EdgeInsets? padding,
  bool isScrollControlled = true,
  bool useSafeArea = true,
}) {
  return showModalBottomSheet(
    context: rootNavigatorKey.currentContext!,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    shape: RoundedRectangleBorder(
      borderRadius: PUtils.kBorderRadiusTop16,
      side: BorderSide(
        color: rootNavigatorKey.currentContext!.color.stroke,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    builder: (context) => SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: context.viewInsets.bottom),
        padding: padding ?? PUtils.kPaddingSymHor16,
        width: context.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 24),
              child: Container(
                height: 6,
                width: 64,
                decoration: BoxDecoration(color: context.color.stroke, borderRadius: PUtils.kBorderRadius16),
              ),
            ),
            content,
            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}
