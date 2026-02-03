part of 'extension.dart';

extension StringExtension on String {
  String tr() => localization.tr(this);
}