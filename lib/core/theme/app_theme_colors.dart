part of 'themes.dart';

// A set of colors for the entire app.

// light
const colorLightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF0D9B8A),
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
  primary: Color(0XFF0D9B8A),
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
    required this.textSub,
    required this.textSoft,
    required this.textStrong,
    required this.text400,
    required this.base,
    required this.stroke,
    required this.line200,
    required this.iconStrong,
    required this.bgElevattion2,
    required this.icon400,
    required this.bgelevation,
    required this.violet100,
    required this.violet600,
    required this.rose100,
    required this.errorColor,
    required this.blue100,
    required this.green500,
  });

  final Color background;
  final Color white;
  final Color black;
  final Color textSub;
  final Color textSoft;
  final Color textStrong;
  final Color text400;
  final Color base;
  final Color base200;
  final Color stroke;
  final Color line200;
  final Color iconStrong;
  final Color bgElevattion2;
  final Color icon400;
  final Color bgelevation;
  final Color violet100;
  final Color violet600;
  final Color rose100;
  final Color errorColor;
  final Color blue100;
  final Color green500;

  static AppThemeColors light = AppThemeColors(
    text400: Color(0xff64748B),
    base200: Color(0xFFF4F4F4),
    background: Color(0xFFFFFFFF),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    textSub: Color(0xFF334155),
    textSoft: Color(0xFF64748B),
    textStrong: Color(0xFF05100C),
    base: Color(0XFF0D9B8A),
    stroke: Color(0xFFE2E8F0),
    line200: Color(0xFFE4E4E7),
    iconStrong: Color(0xFF081711),
    bgElevattion2: Color(0xFFE2F0EE),
    icon400: Color(0xFFA1A1AA),
    bgelevation: Color(0xFFF4F8F8),
    violet100: Color(0xFFEDE9FE),
    violet600: Color(0xFF7C3AED),
    rose100: Color(0xFFFFE4E6),
    errorColor: Color(0xFFDC3E42),
    blue100: Color(0xFF3B82F6),
    green500: Color(0xFF41C772),
  );

  static AppThemeColors dark = AppThemeColors(
    text400: Color(0xff94A3B8),
    base200: Color(0xFF111111),
    background: Color(0xFF000000),
    white: Color(0xFFffffff),
    black: Color(0xFF000000),
    textSub: Color(0xFFCBD5E1),
    textSoft: Color(0xFF94A3B8),
    textStrong: Color(0xFFF8FAFC),
    base: Color(0XFF0D9B8A),
    stroke: Color(0xFF27493D),
    line200: Color(0xFF323233),
    iconStrong: Color(0xFFF8FCFB),
    bgElevattion2: Color(0xFF1D3430),
    icon400: Color(0xFF727278),
    bgelevation: Color(0xFF0A1612),
    violet100: Color(0xFF251D45),
    violet600: Color(0xFF975FF7),
    rose100: Color(0xFF3A1215),
    errorColor: Color(0xFF641723),
    blue100: Color(0xFF60A5FA),
    green500: Color(0xFF41C772),
  );

  @override
  ThemeExtension<AppThemeColors> copyWith({
    Color? background,
    Color? white,
    Color? black,
    Color? textSub,
    Color? textSoft,
    Color? textStrong,
    Color? base,
    Color? stroke,
    Color? line200,
    Color? iconStrong,
    Color? bgElevattion2,
    Color? icon400,
    Color? bgelevation,
    Color? violet100,
    Color? violet600,
    Color? rose100,
    Color? errorColor,
    Color? blue100,
    Color? green500,
  }) {
    return AppThemeColors(
      text400: text400,
      base200: base200,
      background: background ?? this.background,
      white: white ?? this.white,
      black: black ?? this.black,
      textSub: textSub ?? this.textSub,
      textSoft: textSoft ?? this.textSoft,
      textStrong: textStrong ?? this.textStrong,
      base: base ?? this.base,
      stroke: stroke ?? this.stroke,
      line200: line200 ?? this.line200,
      iconStrong: iconStrong ?? this.iconStrong,
      bgElevattion2: bgElevattion2 ?? this.bgElevattion2,
      icon400: icon400 ?? this.icon400,
      bgelevation: bgelevation ?? this.bgelevation,
      violet100: violet100 ?? this.violet100,
      violet600: violet600 ?? this.violet600,
      rose100: rose100 ?? this.rose100,
      errorColor: errorColor ?? this.errorColor,
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
      textSub: Color.lerp(textSub, other.textSub, t)!,
      textSoft: Color.lerp(textSoft, other.textSoft, t)!,
      textStrong: Color.lerp(textStrong, other.textStrong, t)!,
      base: Color.lerp(base, other.base, t)!,
      stroke: Color.lerp(stroke, other.stroke, t)!,
      line200: Color.lerp(line200, other.line200, t)!,
      iconStrong: Color.lerp(iconStrong, other.iconStrong, t)!,
      bgElevattion2: Color.lerp(bgElevattion2, other.bgElevattion2, t)!,
      icon400: Color.lerp(icon400, other.icon400, t)!,
      bgelevation: Color.lerp(bgelevation, other.bgelevation, t)!,
      violet100: Color.lerp(violet100, other.violet100, t)!,
      violet600: Color.lerp(violet600, other.violet600, t)!,
      rose100: Color.lerp(rose100, other.rose100, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      blue100: Color.lerp(blue100, other.blue100, t)!,
      green500: Color.lerp(green500, other.green500, t)!,
    );
  }
}
