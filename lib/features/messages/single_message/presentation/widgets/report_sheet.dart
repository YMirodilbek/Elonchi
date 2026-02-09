import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/messages/single_message/presentation/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportSheet extends StatelessWidget {
  const ReportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            "chat.report".tr(),
            style: TextStyle(color: context.color.textStrong, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ReportItem(title: "Спам", active: false, description: "Нежалательные сообщения", onTap: () {}),
          Divider(color: context.color.stroke),
          ReportItem(title: "Мошенничество", active: false, description: "Я не получил товар или оплату", onTap: () {}),
          Divider(color: context.color.stroke),
          ReportItem(title: "Другое", active: false, description: "Хочу детально объяснить проблему", onTap: () {}),
          Divider(color: context.color.stroke),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ButtonWithScale(
                  onPressed: () {},
                  text: "chat.report".tr(),
                  color: context.color.base,
                  textStyle: TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ButtonWithScale(
                  onPressed: () {
                    context.pop();
                  },
                  text: "Отменить",
                  textStyle: TextStyle(fontWeight: FontWeight.w500, color: context.color.textSoft, fontSize: 16),
                  color: context.color.bgelevation,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
