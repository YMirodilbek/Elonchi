import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/connectivity/network_info.dart';
import 'package:elonchi/core/local_source/local_source.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:elonchi/features/auth/domain/auth_repository.dart';
import 'package:elonchi/features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:elonchi/features/auth/presentation/blocs/otp_bloc/otp_bloc.dart';
import 'package:elonchi/features/categories/domain/categories_repo.dart';
import 'package:elonchi/features/categories/presentation/blocs/bloc/category_bloc.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:elonchi/features/home/presentation/blocs/filters_bloc/filters_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/liked_bloc/like_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:elonchi/features/home/presentation/blocs/watching_bloc/watching_bloc.dart';
import 'package:elonchi/features/messages/all_messages/domain/repository/all_massages_repo.dart';
import 'package:elonchi/features/messages/all_messages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/messages/single_message/presentation/blocs/bloc/single_conversation_bloc.dart';
import 'package:elonchi/features/my_products/domain/repository/my_items_repo.dart';
import 'package:elonchi/features/my_products/presentation/bloc/edit_item_bloc/edit_item_bloc.dart';
import 'package:elonchi/features/my_products/presentation/bloc/my_items_bloc/my_items_bloc.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_main/profile_bloc.dart';
import 'package:elonchi/features/regions/domain/regions_repo.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:elonchi/features/my_products/domain/repository/create_item_repo.dart';
import 'package:elonchi/features/my_products/presentation/bloc/add_bloc/add_item_bloc.dart';
import 'package:elonchi/features/report/domain/report_repo.dart';
import 'package:elonchi/features/report/presentation/bloc/bloc/report_bloc.dart';
import 'package:elonchi/features/single_item/domain/repository/single_repo.dart';
import 'package:elonchi/features/single_item/presentation/blocs/bloc/single_bloc.dart';
import 'package:elonchi/router/app_routes.dart';

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt sl = GetIt.instance;
late Box<dynamic> _box;

final NetworkInfo networkInfo = sl<NetworkInfo>();
final LocalSource localSource = sl<LocalSource>();

// Flag to prevent infinite refresh loops
bool _isRefreshing = false;

Future<void> init() async {
  // hive
  await _initHive();

  // dio
  sl.registerLazySingleton(() => Dio());

  // core
  sl
    ..registerSingleton(InternetConnectionChecker.createInstance(checkInterval: const Duration(seconds: 3)))
    ..registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()))
    ..registerSingleton<LocalSource>(LocalSource(_box))
    ..registerSingleton<RequestManager>(RequestManager(dio: sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(requestManager: sl()))
    ..registerLazySingleton<ProfileRepository>(() => ProfileRepoImpl(sl()))
    ..registerLazySingleton<CreateItemRepo>(() => CreateItemRepoImpl(sl()))
    ..registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImpl(sl()))
    ..registerLazySingleton<RegionsRepo>(() => RegionsRepoImpl(sl()))
    ..registerLazySingleton<MyItemsRepo>(() => MyItemsRepoImpl(sl()))
    ..registerLazySingleton<SingleItemRepo>(() => SingleItemRepoImpl(sl()))
    ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()))
    ..registerLazySingleton<ReportRepo>(() => ReportRepoImpl(sl()))
    ..registerLazySingleton<MessagesRepo>(() => MessagesRepoImpl(sl()))
    ..registerFactory(() => ReportBloc(sl<ReportRepo>()))
    ..registerFactory(() => SingleConversationBloc(sl<MessagesRepo>()))
    ..registerFactory(() => LikeBloc(sl<HomeRepo>()))
    ..registerFactory(() => WatchingBloc(sl<HomeRepo>()))
    ..registerFactory(() => SearchBloc(sl<HomeRepo>()))
    ..registerFactory(() => SingleBloc(sl<SingleItemRepo>()))
    ..registerFactory(() => LoginBloc(authRepository: sl<AuthRepository>()))
    ..registerFactory(() => MyItemsBloc(sl<MyItemsRepo>()))
    ..registerFactory(() => HomeBloc(sl<HomeRepo>(), sl<CategoriesRepo>()))
    ..registerFactory(() => AddItemBloc(sl<CreateItemRepo>()))
    ..registerFactory(() => FiltersBloc())
    ..registerFactory(() => RegionsBloc(sl<RegionsRepo>()))
    ..registerFactory(() => EditItemBloc(sl<CreateItemRepo>()))
    ..registerFactory(() => CategoryBloc(categoriesRepo: sl<CategoriesRepo>()))
    ..registerFactory(() => OtpBloc(authRepository: sl<AuthRepository>(), localSource: sl<LocalSource>()))
    ..registerFactory(() => ProfileEditBloc(reporisitory: sl<ProfileRepository>()))
    ..registerLazySingleton(() => ProfileBloc(reporisitory: sl<ProfileRepository>()))
    ..registerFactory(() => AllMessagesBloc(sl<MessagesRepo>()));

  sl<Dio>().options = BaseOptions(
    contentType: "application/json",
    baseUrl: PConstants.baseUrl,
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: (localSource.isUserLoggedIn)
        ? <String, dynamic>{"Authorization": "Bearer ${localSource.accessToken}"}
        : <String, dynamic>{},
  );

  if (!const bool.fromEnvironment('dart.vm.product')) {
    // Keep your existing pretty logger only in debug
    sl<Dio>().interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  sl<Dio>().interceptors.addAll(<Interceptor>[
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (error, handler) async {
        // Handle 401 errors with token refresh
        if (error.response?.statusCode == 401 && localSource.isUserLoggedIn && !_isRefreshing) {
          _isRefreshing = true; // Set flag to prevent loop

          try {
            // Try to refresh the token
            final authRepo = sl<AuthRepository>();
            final refreshResult = await authRepo.refreshToken();

            if (refreshResult.ok && refreshResult.data != null) {
              // Token refresh successful
              final newAccessToken = refreshResult.data!;

              // Update stored token
              await localSource.setAccessToken(newAccessToken);

              // Update Dio headers with new token
              sl<Dio>().options.headers["Authorization"] = "Bearer $newAccessToken";

              // Retry the original request with new token
              final requestOptions = error.requestOptions;
              requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

              _isRefreshing = false; // Reset flag

              try {
                final response = await sl<Dio>().fetch(requestOptions);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            } else {
              // Refresh token failed or expired - logout user
              _isRefreshing = false; // Reset flag
              await localSource.clearUserData();
              sl<Dio>().options.headers.remove("Authorization");
              rootNavigatorKey.currentContext?.go(Routes.home);
              return handler.next(error);
            }
          } catch (e) {
            // Error during refresh - logout user
            _isRefreshing = false; // Reset flag
            await localSource.clearUserData();
            sl<Dio>().options.headers.remove("Authorization");
            rootNavigatorKey.currentContext?.go(Routes.home);
            return handler.next(error);
          }
        }

        return handler.next(error);
      },
    ),
  ]);
}

Future<void> _initHive() async {
  const String boxName = PKeys.box;
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
