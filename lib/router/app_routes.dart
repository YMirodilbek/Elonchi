import 'package:elonchi/features/auth/domain/auth_repository.dart';
import 'package:elonchi/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:elonchi/features/auth/presentation/blocs/otp_bloc/otp_bloc.dart';
import 'package:elonchi/features/auth/presentation/pages/login_page.dart';
import 'package:elonchi/features/auth/presentation/pages/otp_confirm_page.dart';
import 'package:elonchi/features/home/domain/entities/get_product_request.dart';
import 'package:elonchi/features/home/presentation/blocs/filters_bloc/filters_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/liked_bloc/like_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/watching_bloc/watching_bloc.dart';
import 'package:elonchi/features/home/presentation/pages/filters_page.dart';
import 'package:elonchi/features/home/presentation/pages/hot_sales_page.dart';
import 'package:elonchi/features/home/presentation/pages/my_wishes_page.dart';
import 'package:elonchi/features/home/presentation/pages/search_page.dart';
import 'package:elonchi/features/messages/all_messages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/messages/all_messages/presentation/pages/messages.dart';
import 'package:elonchi/features/messages/single_message/domain/entities/conversation_request.dart';
import 'package:elonchi/features/messages/single_message/presentation/blocs/bloc/single_conversation_bloc.dart';
import 'package:elonchi/features/messages/single_message/presentation/pages/conversation_page.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'dart:convert';
import 'package:elonchi/features/my_products/presentation/bloc/edit_item_bloc/edit_item_bloc.dart';
import 'package:elonchi/features/my_products/presentation/bloc/my_items_bloc/my_items_bloc.dart';
import 'package:elonchi/features/my_products/presentation/pages/edit_item_page.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_main/profile_bloc.dart';
import 'package:elonchi/features/profile/presentation/pages/profile_edit_page.dart';
import 'package:elonchi/features/my_products/presentation/bloc/add_bloc/add_item_bloc.dart';
import 'package:elonchi/features/my_products/presentation/pages/add_item_page.dart';
import 'package:elonchi/features/my_products/presentation/pages/success_state.dart';
import 'package:elonchi/features/single_item/presentation/blocs/bloc/single_bloc.dart';
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
import 'package:elonchi/features/my_products/presentation/pages/my_items_page.dart';
import 'package:elonchi/features/splash/presentation/pages/splash_page.dart';

part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class _GoRouterCodec extends Codec<Object?, Object?> {
  const _GoRouterCodec();

  @override
  Converter<Object?, Object?> get decoder => const _GoRouterDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _GoRouterEncoder();
}

class _GoRouterDecoder extends Converter<Object?, Object?> {
  const _GoRouterDecoder();

  @override
  Object? convert(Object? input) {
    print('🔵 DECODER input type: ${input.runtimeType}');
    print('🔵 DECODER input: $input');
    if (input is Map<String, dynamic> && input['__type'] == 'ConversationRequest') {
      final result = ConversationRequest.fromJson(input);
      print('🔵 DECODER result product image: ${result.product.image}');
      return result;
    }
    return input;
  }
}

class _GoRouterEncoder extends Converter<Object?, Object?> {
  const _GoRouterEncoder();

  @override
  Object? convert(Object? input) {
    print('🟢 ENCODER input type: ${input.runtimeType}');
    if (input is ConversationRequest) {
      final json = {'__type': 'ConversationRequest', ...input.toJson()};
      print('🟢 ENCODER output: $json');
      return json;
    }
    return input;
  }
}

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: Routes.splashScreen,
  extraCodec: const _GoRouterCodec(),
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
      builder: (_, _) => BlocProvider(create: (context) => sl<WatchingBloc>(), child: const HotSalesPage()),
    ),
    GoRoute(
      path: Routes.myWishes,
      name: Routes.myWishes,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => BlocProvider(create: (context) => sl<LikeBloc>(), child: const LikedPage()),
    ),

    GoRoute(
      path: Routes.filtersScreen,
      name: Routes.filtersScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<FiltersBloc>(),
        child: FiltersPage(request: state.extra as GetProductRequest),
      ),
    ),
    GoRoute(
      path: Routes.searchScreen,
      name: Routes.searchScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) {
        final data = state.extra as Map<String, dynamic>;
        return BlocProvider(
          create: (context) => sl<SearchBloc>(),
          child: SearchPage(region: data["region"], category: data["category"]),
        );
      },
    ),
    GoRoute(
      path: Routes.singleItemScreen,
      name: Routes.singleItemScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<SingleBloc>(),
        child: SingleItemPage(itemId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.authScreen,
      name: Routes.authScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => BlocProvider(
        create: (context) => LoginBloc(authRepository: sl<AuthRepository>()),
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      path: Routes.otpConfirmScreen,
      name: Routes.otpConfirmScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) {
        final extras = state.extra as Map<String, dynamic>?;
        return BlocProvider(
          create: (context) => sl<OtpBloc>(),
          child: OtpConfirmPage(
            number: extras?['number'] as String? ?? '',
            initialSeconds: extras?['initialSeconds'] as int?,
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.addItemScreen,
      name: Routes.addItemScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => BlocProvider(create: (context) => sl<AddItemBloc>(), child: const AddItemPage()),
    ),
    GoRoute(
      path: Routes.conversationScreen,
      name: Routes.conversationScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) {
        print('🟠 ROUTE BUILDER extra type: ${state.extra.runtimeType}');
        print('🟠 ROUTE BUILDER extra: ${state.extra}');
        final request = state.extra as ConversationRequest;
        print('🟠 ROUTE BUILDER product image: ${request.product.image}');
        return BlocProvider(
          create: (context) => sl<SingleConversationBloc>(),
          child: ConversationPage(conversationRequest: request),
        );
      },
    ),
    GoRoute(
      path: Routes.successItemAddedScreen,
      name: Routes.successItemAddedScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, _) => const SuccessState(),
    ),
    GoRoute(
      path: Routes.editItemScreen,
      name: Routes.editItemScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) => BlocProvider(
        create: (context) => sl<EditItemBloc>(),
        child: EditItemPage(product: state.extra as ProductResponse),
      ),
    ),
    GoRoute(
      path: Routes.editProfileScreen,
      name: Routes.editProfileScreen,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) => BlocProvider(
        create: (context) => ProfileEditBloc(reporisitory: sl<ProfileRepository>()),
        child: ProfileEditPage(userModel: state.extra as UserModel),
      ),
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
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (_, _) => BlocProvider(create: (context) => sl<HomeBloc>(), child: const HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.race,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.race,
              name: Routes.race,
              builder: (_, _) => BlocProvider(create: (context) => sl<MyItemsBloc>(), child: const MyItemsPage()),
            ),
          ],
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
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (context, state) => BlocProvider.value(value: sl<ProfileBloc>(), child: const ProfilePage()),
            ),
          ],
        ),
      ],
    ),
  ],
);
