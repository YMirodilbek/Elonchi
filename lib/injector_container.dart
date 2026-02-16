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
import 'package:elonchi/features/messages/all_massages/presentation/blocs/all_messages_bloc/all_messages_bloc.dart';
import 'package:elonchi/features/profile/domain/repositories/profile_reporisitory.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:elonchi/features/profile/presentation/blocs/profile_main/profile_bloc.dart';
import 'package:elonchi/features/sell/domain/repository/create_item_repo.dart';
import 'package:elonchi/features/sell/presentation/bloc/bloc/add_item_bloc.dart';
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
    ..registerFactory(() => LoginBloc(authRepository: sl<AuthRepository>()))
    ..registerFactory(() => AddItemBloc(sl<CreateItemRepo>()))
    ..registerFactory(() => OtpBloc(authRepository: sl<AuthRepository>(), localSource: sl<LocalSource>()))
    ..registerFactory(() => ProfileEditBloc(reporisitory: sl<ProfileRepository>()))
    ..registerLazySingleton(() => ProfileBloc(reporisitory: sl<ProfileRepository>()))
    ..registerFactory(() => AllMessagesBloc());

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
        if (error.response?.statusCode == 401 && localSource.isUserLoggedIn) {
          await localSource.clearUserData();
          sl<Dio>().options.headers.remove("Authorization");
          rootNavigatorKey.currentContext?.go(Routes.home);
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
