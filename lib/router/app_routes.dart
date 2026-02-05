import 'package:elonchi/features/splash/presentation/pages/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:elonchi/features/home/presentation/pages/home_page.dart';
import 'package:elonchi/features/main/presentation/bloc/main_bloc.dart';
import 'package:elonchi/features/main/presentation/pages/main_page.dart';
import 'package:elonchi/features/profile/presentation/pages/profile_page.dart';
import 'package:elonchi/features/sell/presentation/pages/race_page.dart';
import 'package:elonchi/features/messages/presentation/pages/ranking.dart';
import 'package:elonchi/features/splash/presentation/pages/splash_page.dart';

part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: Routes.splashScreen,

  routes: <RouteBase>[
    GoRoute(
      path: Routes.splashScreen,
      name: Routes.splashScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.languageScreen,
      name: Routes.languageScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const LanguagePage(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state, StatefulNavigationShell navigationShell) {
        return BlocProvider(
          create: (context) => MainBloc(),
          child: MainPage(key: state.pageKey, navigationShell: navigationShell),
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: <RouteBase>[GoRoute(path: Routes.home, name: Routes.home, builder: (_, __) => HomePage())],
        ),
        StatefulShellBranch(
          initialLocation: Routes.race,
          routes: <RouteBase>[GoRoute(path: Routes.race, name: Routes.race, builder: (_, __) => RacePage())],
        ),
        StatefulShellBranch(
          initialLocation: Routes.ranking,
          routes: <RouteBase>[GoRoute(path: Routes.ranking, name: Routes.ranking, builder: (_, __) => RankingPage())],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(path: Routes.profile, name: Routes.profile, builder: (context, state) => ProfilePage()),
          ],
        ),
      ],
    ),
  ],
);
