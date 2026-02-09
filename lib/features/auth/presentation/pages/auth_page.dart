import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/auth/presentation/widgets/login_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WScaleAnimation(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(PIcons.arrowLeftIcon),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/images/login.png', height: 80, width: 80),
              const SizedBox(height: 20),
              Text(
                'Войти',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.color.textStrong),
              ),
              const SizedBox(height: 5),
              Text(
                'Введите номер телефона. Мы отправим код для подтверждения',
                style: TextStyle(color: context.color.textSub),
              ),
              const SizedBox(height: 20),
              PhoneInputs(onChanged: (value) {}, onTap: () {}, controller: TextEditingController()),
              const Spacer(),
              ButtonWithScale(
                onPressed: () {},
                text: 'Получить код',
                textStyle: TextStyle(color: context.color.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
