import 'package:elonchi/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWithtext extends StatelessWidget {
  const LogoWithtext({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          const Spacer(),
          SvgPicture.asset(PIcons.mainLogo),
          const SizedBox(width: 10),
          SvgPicture.asset(PIcons.mainLogoText),
          const Spacer(),
        ],
      ),
    );
  }
}
