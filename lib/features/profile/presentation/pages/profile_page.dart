import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_main/profile_bloc.dart';
import 'package:elonchi/features/profile/presentation/widgets/empty_user.dart';
import 'package:elonchi/features/profile/presentation/widgets/log_out_sheet.dart';
import 'package:elonchi/features/profile/presentation/widgets/login_button.dart';
import 'package:elonchi/features/profile/presentation/widgets/profile_item.dart';
import 'package:elonchi/features/profile/presentation/widgets/theme_sheet.dart';
import 'package:elonchi/features/profile/presentation/widgets/top_part_profile.dart';
import 'package:elonchi/injector_container.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ProfileBloc>();
    bloc.add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
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
                const SizedBox(height: 16),
                if (state.loggedIn)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: WScaleAnimation(
                      onTap: () async {
                        final value = await triggerBottomSheet<bool>(content: LogOutSheet());
                        if (value != null && value) {
                          localSource.setAccessToken('');
                          sl<Dio>().options.headers.remove("Authorization");
                          context.go(Routes.splashScreen);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(PIcons.logOutIcon, color: context.color.errorColor),
                          const SizedBox(width: 8),
                          Text('Выйти', style: TextStyle(color: context.color.errorColor)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          floatingActionButton: !state.loggedIn
              ? LoginButton(
                  onTap: () {
                    context.push(Routes.authScreen);
                  },
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
