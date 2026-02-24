import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(PIcons.platformInfoImg, height: 67),
            const SizedBox(height: 20),
            Text("Вы точно хотите удалить?", style: TextStyle(color: context.color.textStrong, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ButtonWithScale(
                    onPressed: () {
                      context.pop(true);
                    },
                    text: "Удалить",
                    textStyle: TextStyle(fontWeight: FontWeight.w500, color: context.color.white),
                    color: context.color.errorColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ButtonWithScale(
                    onPressed: () {
                      context.pop();
                    },
                    text: "Отменить",
                    textStyle: TextStyle(fontWeight: FontWeight.w500, color: context.color.textSoft),
                    color: context.color.bgelevation,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
