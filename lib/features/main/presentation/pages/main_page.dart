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
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: context.color.background,
            border: Border(top: BorderSide(width: 1, color: context.color.icon300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: NavbarItem(
                  label: 'Поиск',
                  iconPath: PIcons.homeIcon,
                  active: widget.navigationShell.currentIndex == 0,
                  onTap: () {
                    // AppMetrica.reportEvent('Home Button Clicked');
                    widget.navigationShell.goBranch(0);
                  },
                ),
              ),

              Expanded(
                child: NavbarItem(
                  iconPath: PIcons.messageIcon,
                  label: 'Продать',
                  active: widget.navigationShell.currentIndex == 1,
                  onTap: () {
                    // AppMetrica.reportEvent('Home Button Clicked');
                    widget.navigationShell.goBranch(1);
                  },
                ),
              ),
              Expanded(
                child: NavbarItem(
                  label: 'Сообщения',
                  iconPath: PIcons.sellIcon,
                  active: widget.navigationShell.currentIndex == 2,
                  onTap: () {
                    // AppMetrica.reportEvent('Home Button Clicked');
                    widget.navigationShell.goBranch(2);
                  },
                ),
              ),
              Expanded(
                child: NavbarItem(
                  iconPath: PIcons.profileIcon,
                  label: 'Войти',
                  active: widget.navigationShell.currentIndex == 3,
                  onTap: () {
                    // AppMetrica.reportEvent('Home Button Clicked');
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
