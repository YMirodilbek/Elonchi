import 'package:elonchi/core/local_source/local_source.dart';
import 'package:elonchi/injector_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show Platform;

import '../utils/utils.dart';

// Add this background message handler at the top level
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printInfo('Handling a background message: ${message.messageId}');
}

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // function to request notifications permissions
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        printInfo('user granted permission');
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        printInfo('user granted provisional permission');
      }
    } else {
      // AppSettings.openNotificationSettings();
      if (kDebugMode) {
        printInfo('user denied permission');
      }
    }
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
    );

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        printInfo("handle notify");
        try {
          //  GoRouter.of(context).push(Constants.notification);
        } catch (e) {
          printInfo(e.toString());
        }
      },
    );
    messaging.getInitialMessage().then((message) {
      // if (message != null && context.mounted) {
      //   GoRouter.of(context).push(Constants.notification);
      // }
    });
  }

  void firebaseInit(BuildContext context) {
    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      printInfo('Got a message whilst in the foreground!');
      showNotification(message);
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel? channel;
    AndroidNotificationDetails? androidNotificationDetails;

    try {
      channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        showBadge: true,
        playSound: true,
      );

      // Create the channel on Android
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'SAPI notifications',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
      );
    } catch (e) {
      printInfo('Error creating notification channel: $e');
    }

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android:
          androidNotificationDetails ??
          const AndroidNotificationDetails("high_importance_channel", "High Importance Notifications"),
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        message.notification?.title ?? 'New notification',
        message.notification?.body ?? 'You have a new message',
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token;
    final LocalSource localSource = sl<LocalSource>();

    try {
      if (Platform.isIOS) {
        print('🔷 [iOS] Checking iOS device type...');
        // Try to get APNS token with longer timeout
        String? apnsToken;
        int maxRetries = 5;

        for (int i = 0; i < maxRetries; i++) {
          print('🔷 [iOS] Attempting to get APNS token... (${i + 1}/$maxRetries)');
          apnsToken = await messaging.getAPNSToken();

          if (apnsToken != null) {
            print('✅ [iOS] APNS token received: ${apnsToken.substring(0, 20)}...');
            break;
          }

          // Wait longer between retries
          await Future.delayed(Duration(seconds: 2 + i));
        }

        if (apnsToken != null) {
          // Now get FCM token
          token = await messaging.getToken();
          print('✅ [iOS] FCM token: $token');

          // Store token locally
          if (token != null) {
            await localSource.setFcmToken(token);
          }
        } else {
          print('❌ [iOS] APNS token not available');
          String cachedToken = localSource.fcmToken;
          if (cachedToken.isNotEmpty) {
            print('📱 [iOS] Using cached FCM token: $cachedToken');
            return cachedToken;
          }

          try {
            token = await messaging.getToken();
            print('ℹ️  [iOS Simulator] FCM token: $token');
          } catch (e) {
            print('⚠️  [iOS Simulator] Expected error: $e');
            return localSource.fcmToken;
          }
        }
      } else {
        // For Android, get token directly
        print('🟢 [Android] Getting FCM token...');
        token = await messaging.getToken();
        print('✅ [Android] FCM token: $token');

        // Store token locally
        if (token != null) {
          await localSource.setFcmToken(token);
          print('💾 [Android] Token saved locally');
        }
      }
    } catch (e) {
      print('❌ [Error] Getting device token failed: $e');
      // Return cached token if available
      return localSource.fcmToken;
    }

    print('📤 [Result] Returning token: ${token ?? localSource.fcmToken}');
    return token ?? localSource.fcmToken;
  }

  // Get cached FCM token
  String getCachedFcmToken() {
    final LocalSource localSource = sl<LocalSource>();
    return localSource.fcmToken;
  }

  // Clear FCM token
  Future<void> clearFcmToken() async {
    final LocalSource localSource = sl<LocalSource>();
    await localSource.clearFcmToken();
  }

  // Send FCM token to backend (optional - call this after login)
  Future<void> sendTokenToBackend() async {
    final LocalSource localSource = sl<LocalSource>();
    String token = localSource.fcmToken;

    if (token.isNotEmpty) {
      printInfo('📤 Sending FCM token to backend: $token');
      // TODO: Implement API call to send token to your backend
      // Example:
      // await sl<RequestManager>().request(
      //   requestType: RequestType.post,
      //   path: PUrls.registerFmc,
      //   data: {'fcm_token': token, 'device_type': Platform.isIOS ? 'ios' : 'android'},
      // );
    }
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (context.mounted) {
        handleMessage(context, event);
      }
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    printInfo('Handling message: ${message.data}');
    //  GoRouter.of(context).push(Constants.notification);
  }
}
