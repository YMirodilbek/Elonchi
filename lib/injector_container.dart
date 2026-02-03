// import 'dart:math';
// import "package:dio/dio.dart";
// import 'package:get_it/get_it.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import "dart:developer";
// import "dart:io";

// final GetIt sl = GetIt.instance;

// Future<void> init() async {
//   // hive

//   // dio
//   sl.registerLazySingleton(() => Dio());

//   // core
//   sl
//     ..registerSingleton(InternetConnectionChecker.createInstance(checkInterval: const Duration(seconds: 3)))
//     ..registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()))
//     ..registerSingleton<LocalSource>(LocalSource(_box))
//     ..registerSingleton<RequestManager>(RequestManager(dio: sl()));

//   // sl<Dio>().options = BaseOptions(
//   //   contentType: "application/json",
//   //   baseUrl: PConstants.baseUrl,
//   //   sendTimeout: const Duration(seconds: 30),
//   //   connectTimeout: const Duration(seconds: 30),
//   //   receiveTimeout: const Duration(seconds: 30),
//   //   headers: (localSource.isUserLoggedIn)
//   //       ? <String, dynamic>{"Authorization": "Bearer ${localSource.accessToken}"}
//   //       : <String, dynamic>{},
//   // );

//   // sl<Dio>().interceptors.addAll(<Interceptor>[
//   //   if (kDebugMode)
//   //     PrettyDioLogger(
//   //       requestHeader: true,
//   //       requestBody: true,
//   //       responseBody: true,
//   //       responseHeader: true,
//   //       error: true,
//   //       request: true,
//   //       compact: true,
//   //       maxWidth: 90,
//   //       logPrint: (Object object) {
//   //         log("$object");
//   //       },
//   //     ),

//     // LogInterceptor(
//     //   error: kDebugMode,
//     //   request: kDebugMode,
//     //   requestBody: kDebugMode,
//     //   responseBody: kDebugMode,
//     //   requestHeader: kDebugMode,
//     //   responseHeader: kDebugMode,
//     //   logPrint: (Object object) {
//     //     if (kDebugMode) {
//     //       log("dio: $object");
//     //     }
//     //   },
//     // ),
//   ]);
// }
