import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessState extends StatelessWidget {
  const SuccessState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/success.png', height: 72),
              const SizedBox(height: 16),
              Text(
                'Объявление отправлено на проверку',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
              ),
              const SizedBox(height: 8),
              Text(
                "Мы проверим информацию и фотографии  Обычно это занимает немного времени",
                style: TextStyle(fontSize: 14, color: context.color.textSub),
              ),
              const Spacer(),
              ButtonWithScale(
                onPressed: () {
                  context.pop();
                },
                text: 'Перейти к моим объявлениям',
                textStyle: TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
