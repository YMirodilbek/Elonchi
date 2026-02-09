import 'package:elonchi/features/auth/presentation/pages/auth_page.dart';
import 'package:elonchi/features/home/presentation/pages/categories_page.dart';
import 'package:elonchi/features/home/presentation/pages/filters_page.dart';
import 'package:elonchi/features/home/presentation/pages/hot_sales_page.dart';
import 'package:elonchi/features/home/presentation/pages/my_wishes_page.dart';
import 'package:elonchi/features/home/presentation/pages/search_page.dart';
import 'package:elonchi/features/messages/all_massages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/messages/all_massages/presentation/pages/messages.dart';
import 'package:elonchi/features/messages/single_message/presentation/pages/conversation_page.dart';
import 'package:elonchi/features/sell/presentation/pages/add_item_page.dart';
import 'package:elonchi/features/single_item/presentation/pages/single_item_page.dart';
import 'package:elonchi/features/splash/presentation/pages/language_screen.dart';
import 'package:elonchi/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:elonchi/features/home/presentation/pages/home_page.dart';
import 'package:elonchi/features/main/presentation/bloc/main_bloc.dart';
import 'package:elonchi/features/main/presentation/pages/main_page.dart';
import 'package:elonchi/features/profile/presentation/pages/profile_page.dart';
import 'package:elonchi/features/sell/presentation/pages/sell_page.dart';
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
    GoRoute(
      path: Routes.salesScreen,
      name: Routes.salesScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const HotSalesPage(),
    ),
    GoRoute(
      path: Routes.myWishes,
      name: Routes.myWishes,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const LikedPage(),
    ),
    GoRoute(
      path: Routes.categoriesScreen,
      name: Routes.categoriesScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const CategoriesPage(),
    ),
    GoRoute(
      path: Routes.filtersScreen,
      name: Routes.filtersScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const FiltersPage(),
    ),
    GoRoute(
      path: Routes.searchScreen,
      name: Routes.searchScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const SearchPage(),
    ),
    GoRoute(
      path: Routes.singleItemScreen,
      name: Routes.singleItemScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const SingleItemPage(),
    ),
    GoRoute(
      path: Routes.authScreen,
      name: Routes.authScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const AuthPage(),
    ),
    GoRoute(
      path: Routes.addItemScreen,
      name: Routes.addItemScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const AddItemPage(),
    ),

    GoRoute(
      path: Routes.conversationScreen,
      name: Routes.conversationScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const ConversationPage(),
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
          routes: <RouteBase>[GoRoute(path: Routes.home, name: Routes.home, builder: (_, _) => const HomePage())],
        ),
        StatefulShellBranch(
          initialLocation: Routes.race,
          routes: <RouteBase>[GoRoute(path: Routes.race, name: Routes.race, builder: (_, _) => const SellPage())],
        ),
        StatefulShellBranch(
          initialLocation: Routes.messages,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.messages,
              name: Routes.messages,
              builder: (_, _) => BlocProvider(create: (context) => sl<AllMessagesBloc>(), child: const MessagesPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(path: Routes.profile, name: Routes.profile, builder: (context, state) => const ProfilePage()),
          ],
        ),
      ],
    ),
  ],
);
