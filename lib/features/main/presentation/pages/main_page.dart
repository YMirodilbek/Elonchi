import 'package:elonchi/core/firebase_notification/firebase_notification_manager.dart';
import 'package:elonchi/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/main/presentation/widgets/navbar_item.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    final NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotificationPermission();
    notificationServices.initLocalNotifications(context);
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices
        .getDeviceToken()
        .then((token) {
          localSource.setFcmToken(token);
        })
        .catchError((e) {
          print('❌ Error getting device token: $e');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: context.color.background,
            border: Border(top: BorderSide(width: 1, color: context.color.bgelevation)),
          ),
          child: Row(
            children: [
              Expanded(
                child: NavbarItem(
                  label: "nav.search".tr(),
                  iconPath: PIcons.homeIcon,
                  active: widget.navigationShell.currentIndex == 0,
                  onTap: () {
                    widget.navigationShell.goBranch(0);
                  },
                ),
              ),
              Expanded(
                child: NavbarItem(
                  iconPath: PIcons.messageIcon,
                  label: "nav.sell".tr(),
                  active: widget.navigationShell.currentIndex == 1,
                  onTap: () {
                    widget.navigationShell.goBranch(1);
                  },
                ),
              ),
              Expanded(
                child: NavbarItem(
                  label: "nav.messages".tr(),
                  iconPath: PIcons.sellIcon,
                  active: widget.navigationShell.currentIndex == 2,
                  onTap: () {
                    widget.navigationShell.goBranch(2);
                  },
                ),
              ),
              Expanded(
                child: NavbarItem(
                  iconPath: localSource.isUserLoggedIn ? PIcons.profileIcon : PIcons.profileUnAuth,
                  label: localSource.isUserLoggedIn ? "nav.profile".tr() : "nav.login".tr(),
                  active: widget.navigationShell.currentIndex == 3,
                  onTap: () {
                    widget.navigationShell.goBranch(3);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
