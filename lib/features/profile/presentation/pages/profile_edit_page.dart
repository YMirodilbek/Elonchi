import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WScaleAnimation(
          onTap: () {
            context.pop();
          },
          child: Padding(padding: const EdgeInsets.all(11.0), child: SvgPicture.asset(PIcons.arrowLeftIcon)),
        ),
        title: Text(
          'Мой профиль',
          style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
