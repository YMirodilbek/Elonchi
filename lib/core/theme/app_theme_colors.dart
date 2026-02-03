part of 'themes.dart';

// A set of colors for the entire app.

// light
const colorLightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF975FF7),
  onPrimary: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
  secondary: Color(0xFF3DC564),
  onSecondary: Colors.black,
  error: Color(0xFFE9033A),
  onError: Colors.white,
);

// dark
const colorDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0XFFBE4FED),
  onPrimary: Colors.white,
  surface: Colors.black,
  onSurface: Colors.white,
  secondary: Color(0xFF20CBF1),
  onSecondary: Colors.black,
  error: Color(0xFFE9033A),
  onError: Colors.white,
);

// custom
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.base200,
    required this.background,
    required this.white,
    required this.black,
    required this.text900,
    required this.text600,
    required this.text500,
    required this.text400,
    required this.base,
    required this.line100,
    required this.line200,
    required this.icon900,
    required this.icon500,
    required this.icon400,
    required this.icon300,
    required this.violet100,
    required this.violet600,
    required this.rose100,
    required this.rose600,
    required this.blue100,
    required this.green500,
  });

  final Color background;
  final Color white;
  final Color black;
  final Color text900;
  final Color text600;
  final Color text500;
  final Color text400;
  final Color base;
  final Color base200;
  final Color line100;
  final Color line200;
  final Color icon900;
  final Color icon500;
  final Color icon400;
  final Color icon300;
  final Color violet100;
  final Color violet600;
  final Color rose100;
  final Color rose600;
  final Color blue100;
  final Color green500;

  static AppThemeColors light = AppThemeColors(
    text400: Color(0xff616166),
    base200: Color(0xFF20CBF1),
    background: Color(0xFFFFFFFF),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    text900: Color(0xFF18181B),
    text600: Color(0xFF52525B),
    text500: Color(0xFF71717A),
    base: Color(0XFFBE4FED),
    line100: Color(0xFFF4F4F5),
    line200: Color(0xFFE4E4E7),
    icon900: Color(0xFF18181B),
    icon500: Color(0xFF71717A),
    icon400: Color(0xFFA1A1AA),
    icon300: Color(0xFFD4D4D8),
    violet100: Color(0xFFEDE9FE),
    violet600: Color(0xFF7C3AED),
    rose100: Color(0xFFFFE4E6),
    rose600: Color(0xFFE11D48),
    blue100: Color(0xFF3B82F6),
    green500: Color(0xFF41C772),
  );

  static AppThemeColors dark = AppThemeColors(
    text400: Color(0xff616166),
    base200: Color(0xFF20CBF1),
    background: Color(0xFF000000),
    white: Color(0xFFffffff),
    black: Color(0xFF000000),
    text900: Color(0xFFFFFFFF),
    text600: Color(0xFFB5B5BD),
    text500: Color(0xFF8D8D94),
    base: Color(0XFFBE4FED),
    line100: Color(0xFF292929),
    line200: Color(0xFF323233),
    icon900: Color(0xFFFFFFFF),
    icon500: Color(0xFF94949C),
    icon400: Color(0xFF727278),
    icon300: Color(0xFF5D5D5E),
    violet100: Color(0xFF251D45),
    violet600: Color(0xFF975FF7),
    rose100: Color(0xFF3A1215),
    rose600: Color(0xFFFF325F),
    blue100: Color(0xFF60A5FA),
    green500: Color(0xFF41C772),
  );

  @override
  ThemeExtension<AppThemeColors> copyWith({
    Color? background,
    Color? white,
    Color? black,
    Color? text900,
    Color? text600,
    Color? text500,
    Color? base,
    Color? line100,
    Color? line200,
    Color? icon900,
    Color? icon500,
    Color? icon400,
    Color? icon300,
    Color? violet100,
    Color? violet600,
    Color? rose100,
    Color? rose600,
    Color? blue100,
    Color? green500,
  }) {
    return AppThemeColors(
      text400: text400,
      base200: base200,
      background: background ?? this.background,
      white: white ?? this.white,
      black: black ?? this.black,
      text900: text900 ?? this.text900,
      text600: text600 ?? this.text600,
      text500: text500 ?? this.text500,
      base: base ?? this.base,
      line100: line100 ?? this.line100,
      line200: line200 ?? this.line200,
      icon900: icon900 ?? this.icon900,
      icon500: icon500 ?? this.icon500,
      icon400: icon400 ?? this.icon400,
      icon300: icon300 ?? this.icon300,
      violet100: violet100 ?? this.violet100,
      violet600: violet600 ?? this.violet600,
      rose100: rose100 ?? this.rose100,
      rose600: rose600 ?? this.rose600,
      blue100: blue100 ?? this.blue100,
      green500: green500 ?? this.green500,
    );
  }

  @override
  ThemeExtension<AppThemeColors> lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;

    return AppThemeColors(
      text400: Color.lerp(text400, other.text400, t)!,
      base200: Color.lerp(base, other.base, t)!,
      background: Color.lerp(background, other.background, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      text900: Color.lerp(text900, other.text900, t)!,
      text600: Color.lerp(text600, other.text600, t)!,
      text500: Color.lerp(text500, other.text500, t)!,
      base: Color.lerp(base, other.base, t)!,
      line100: Color.lerp(line100, other.line100, t)!,
      line200: Color.lerp(line200, other.line200, t)!,
      icon900: Color.lerp(icon900, other.icon900, t)!,
      icon500: Color.lerp(icon500, other.icon500, t)!,
      icon400: Color.lerp(icon400, other.icon400, t)!,
      icon300: Color.lerp(icon300, other.icon300, t)!,
      violet100: Color.lerp(violet100, other.violet100, t)!,
      violet600: Color.lerp(violet600, other.violet600, t)!,
      rose100: Color.lerp(rose100, other.rose100, t)!,
      rose600: Color.lerp(rose600, other.rose600, t)!,
      blue100: Color.lerp(blue100, other.blue100, t)!,
      green500: Color.lerp(green500, other.green500, t)!,
    );
  }
}
