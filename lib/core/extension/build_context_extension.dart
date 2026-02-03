part of "extension.dart";

extension BuildContextExt on BuildContext {
  Locale? get locale => localization.EasyLocalization.of(this)?.locale;

  Future<void>? setLocale(Locale locale) => localization.EasyLocalization.of(this)?.setLocale(locale);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppThemeColors get color => theme.extension<AppThemeColors>()!;

  ThemeTextStyles get textStyle => theme.extension<ThemeTextStyles>()!;
}
