import "package:elonchi/core/extension/extension.dart";
import "package:elonchi/core/utils/imports.dart";
import "package:elonchi/main.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:intl/date_symbol_data_local.dart";

import "../../constants/constants.dart";

final class LocalSource {
  LocalSource(this.box);

  final Box<dynamic> box;

  // locale

  String get locale {
    return box.get(PKeys.locale, defaultValue: defaultLocale);
  }

  Future<void> setLocale(BuildContext context, String locale) async {
    await context.setLocale(Locale(locale));
    await initializeDateFormatting(locale);
    symbols = dateTimeSymbolMap()[locale];

    await box.put(PKeys.locale, locale);
  }

  // theme mode

  ThemeMode get themeMode => switch (box.get(PKeys.themeMode, defaultValue: "system")) {
    "system" => ThemeMode.system,
    "light" => ThemeMode.light,
    "dark" => ThemeMode.dark,
    _ => ThemeMode.light,
  };

  Future<void> setThemeMode(ThemeMode mode) async {
    await box.put(PKeys.themeMode, mode.name);
  }

  // access token

  String get accessToken {
    return box.get(PKeys.accessToken, defaultValue: "");
  }

  Future<void> setAccessToken(String accessToken) async {
    await box.put(PKeys.accessToken, accessToken);
  }

  // refresh token

  Future<void> setRefreshToken(String refreshToken) async {
    await box.put(PKeys.refreshToken, refreshToken);
  }

  String get refreshToken {
    return box.get(PKeys.refreshToken, defaultValue: "");
  }

  // user id

  Future<void> setUserId(int userId) async {
    await box.put(PKeys.userId, userId);
  }

  int get userId {
    return box.get(PKeys.userId, defaultValue: 0);
  }

  //creator

  Future<void> setCreator(bool isCreator) async {
    await box.put(PKeys.isCreator, isCreator);
  }

  bool get isCreator {
    return box.get(PKeys.isCreator, defaultValue: false);
  }

  // first name

  Future<void> setFirstName(String firstName) async {
    await box.put(PKeys.firstname, firstName);
  }

  String get firstName {
    return box.get(PKeys.firstname, defaultValue: "");
  }

  // last name

  Future<void> setLastName(String userName) async {
    await box.put(PKeys.lastname, userName);
  }

  String get lastName {
    return box.get(PKeys.lastname, defaultValue: "");
  }

  // phone

  Future<void> setPhone(String phone) async {
    await box.put(PKeys.phone, phone);
  }

  String get phone {
    return box.get(PKeys.phone, defaultValue: "");
  }

  // phone

  //onboarded

  Future<void> setOnboarded(bool value) async {
    await box.put(PKeys.onboarded, value);
  }

  bool get onBoarded {
    return box.get(PKeys.onboarded, defaultValue: false);
  }

  //onboarded

  Future<void> setAvatar(String avatar) async {
    await box.put(PKeys.avatar, avatar);
  }

  String get avatar {
    return box.get(PKeys.avatar, defaultValue: "");
  }

  // show lottie

  Future<void> setShowLottie(bool showLottie) async {
    await box.put(PKeys.showLottie, showLottie);
  }

  bool get showLottie {
    return box.get(PKeys.showLottie, defaultValue: true);
  }

  // FCM token

  Future<void> setFcmToken(String fcmToken) async {
    await box.put(PKeys.fcmToken, fcmToken);
  }

  String get fcmToken {
    return box.get(PKeys.fcmToken, defaultValue: "");
  }

  // Clear FCM token
  Future<void> clearFcmToken() async {
    await box.delete(PKeys.fcmToken);
  }

  Future<void> clearUserData() async {
    await box.delete(PKeys.accessToken);
    await box.delete(PKeys.refreshToken);
    await box.delete(PKeys.userId);
    await box.delete(PKeys.avatar);
    await box.delete(PKeys.firstname);
    await box.delete(PKeys.lastname);
    await box.delete(PKeys.phone);
    await box.delete(PKeys.password);
  }

  bool get isUserLoggedIn => accessToken.isNotEmpty;

  Future<void> clear() async {
    await box.clear();
  }

  // image url
  Future<void> setImageUrl(String url) async {
    await box.put(PKeys.imageUrl, url);
  }

  String get imageUrl {
    return box.get(PKeys.imageUrl, defaultValue: "");
  }

  //image url
}
