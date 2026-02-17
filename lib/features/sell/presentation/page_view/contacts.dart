import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/auth/presentation/widgets/login_input.dart';
import 'package:flutter/material.dart';

class ContancsForm extends StatelessWidget {
  final void Function(String name) onNameChanged;
  final void Function(String phone) onPhoneChanged;
  const ContancsForm({super.key, required this.onNameChanged, required this.onPhoneChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Контакты для связи', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Выберите удобные способы связи с покупателями', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 32),
          Container(
            padding: .symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text('Ваше имя', style: TextStyle(fontSize: 12, color: context.color.textSoft)),
                TextField(
                  onChanged: onNameChanged,
                  decoration: InputDecoration(
                    border: .none,
                    hintText: "Имя",
                    hintStyle: TextStyle(color: context.color.textSub, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: TextStyle(color: context.color.textSub),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: .symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text('Телефон номер ', style: TextStyle(fontSize: 12, color: context.color.textSoft)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '+998',
                      style: TextStyle(color: context.color.textSub, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        onChanged: onPhoneChanged,
                        keyboardType: TextInputType.number,
                        inputFormatters: [UzbekPhoneFormatter()],
                        decoration: InputDecoration(border: .none, contentPadding: .only(bottom: 2)),
                        style: TextStyle(color: context.color.textSub, fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
