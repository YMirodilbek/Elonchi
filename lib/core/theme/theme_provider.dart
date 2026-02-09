// lib/core/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:elonchi/core/theme/theme_manager.dart';

class ThemeProvider extends InheritedNotifier<ThemeManager> {
  const ThemeProvider({super.key, required ThemeManager themeManager, required super.child})
    : super(notifier: themeManager);

  static ThemeManager of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(provider != null, 'No ThemeProvider found in context');
    return provider!.notifier!;
  }
}
