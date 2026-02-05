import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/features/profile/presentation/widgets/empty_user.dart';
import 'package:elonchi/features/profile/presentation/widgets/login_button.dart';
import 'package:elonchi/features/profile/presentation/widgets/profile_item.dart';
import 'package:elonchi/features/profile/presentation/widgets/theme_sheet.dart';
import 'package:elonchi/features/profile/presentation/widgets/top_part_profile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TopPartProfile(onTap: () {}),
            const SizedBox(height: 20),
            const EmptyUser(),
            const SizedBox(height: 12),
            ProfileItem(title: 'Мои объявления', iconPath: PIcons.myAnnoucementscon, onTap: () {}),
            const SizedBox(height: 12),
            ProfileItem(title: "Мои желания", iconPath: PIcons.favouriteProfileIcon, onTap: () {}),
            const SizedBox(height: 16),
            Text("pool.create.settings".tr(), style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ProfileItem(
              title: "theme.title".tr(),
              iconPath: PIcons.themeIcon,
              onTap: () {
                triggerBottomSheet(content: ThemeSheet());
              },
              borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            Container(height: 1, color: Color(0xffE2E8F0)),
            ProfileItem(
              title: "Язык",
              iconPath: PIcons.languageSquareIcon,
              onTap: () {},
              borderRadiusGeometry: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            const SizedBox(height: 16),
            Text("Информация".tr(), style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ProfileItem(
              title: "О платформе",
              iconPath: PIcons.infoIcon,
              onTap: () {},
              borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            Container(height: 1, color: Color(0xffE2E8F0)),
            ProfileItem(
              title: "Поддержка",
              iconPath: PIcons.supportIcon,
              onTap: () {},
              borderRadiusGeometry: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      floatingActionButton: LoginButton(onTap: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
