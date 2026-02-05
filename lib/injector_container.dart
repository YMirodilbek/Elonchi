import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/connectivity/network_info.dart';
import 'package:elonchi/core/local_source/local_source.dart';
import 'package:elonchi/core/network/request_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
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
    ..registerSingleton<RequestManager>(RequestManager(dio: sl()));

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

  sl<Dio>().interceptors.addAll(<Interceptor>[
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        request: true,
        compact: true,
        maxWidth: 90,
        logPrint: (Object object) {
          //log("$object");
        },
      ),
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (error, handler) async {
        // if (await networkInfo.isConnected == false) {
        //   final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
        //   final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
        //   final String location = matchList.uri.toString();
        //   if (location.contains(Routes.noInternet)) {
        //     return;
        //   }
        //
        //   await router.push(Routes.noInternet);
        //
        //   return handler.reject(error);
        // }
        // CustomSneakBar.show(
        //   status: SneakBarStatus.error,
        //   message: (error.response?.data is Map &&
        //           error.response?.data.containsKey('detail'))
        //       ? error.response?.data['detail'].toString()
        //       : error.response?.data.toString(),
        // );
        // if (error.response?.statusCode == 401 && localSource.isUserLoggedIn) {
        //   await localSource.clearUserData();
        //   sl<Dio>().options.headers.remove("Authorization");
        //   rootNavigatorKey.currentContext?.go(Routes.signIn);
        // }

        // if (error.response?.statusCode == 401 && localSource.isUserLoggedIn) {
        //   final result = await sl<AuthRepository>().refresh(
        //     localSource.refreshToken,
        //   );
        //
        //   result.fold(
        //     (left) async {
        //       await localSource.clearUserData();
        //       rootNavigatorKey.currentContext?.go(Routes.signIn);
        //
        //       return handler.reject(error);
        //     },
        //     (right) async {
        //       localSource.setAccessToken(right.accessToken ?? "");
        //       sl<Dio>().options.headers["x-access-token"] = right.accessToken;
        //
        //       final newOptions = error.requestOptions;
        //       final response = await sl<Dio>().request(
        //         newOptions.path,
        //         options: Options(
        //           contentType: "application/json",
        //           method: newOptions.method,
        //           headers: <String, dynamic>{
        //             "x-access-token": right.accessToken,
        //           },
        //         ),
        //         data: newOptions.data,
        //         queryParameters: newOptions.queryParameters,
        //       );
        //
        //       return handler.resolve(response);
        //     },
        //   );
        // } else {
        //   return handler.next(error);
        // }
        return handler.next(error);
      },
    ),
    // LogInterceptor(
    //   error: kDebugMode,
    //   request: kDebugMode,
    //   requestBody: kDebugMode,
    //   responseBody: kDebugMode,
    //   requestHeader: kDebugMode,
    //   responseHeader: kDebugMode,
    //   logPrint: (Object object) {
    //     if (kDebugMode) {
    //       log("dio: $object");
    //     }
    //   },
    // ),
  ]);
}

Future<void> _initHive() async {
  const String boxName = PKeys.box;
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
