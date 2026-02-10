part of "utils.dart";

AnsiPen debug = AnsiPen()..gray(level: 0.5);
AnsiPen warning = AnsiPen()..yellow(bold: true);
AnsiPen error = AnsiPen()..red(bold: true);
AnsiPen info = AnsiPen()..blue(bold: true);
AnsiPen success = AnsiPen()..green(bold: true);

void printWarning(String text) {
  debugPrint(warning(text));
  debugPrint(debug(""));
}

void printError(String text) {
  debugPrint(error(text));
  debugPrint(debug(""));
}

void printInfo(String text) {
  debugPrint(info(text));
  debugPrint(debug(""));
}

void printSuccess(String text) {
  debugPrint(success(text));
  debugPrint(debug(""));
}
