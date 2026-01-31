// ignore_for_file: avoid_print
class LogHelper {
  // ANSI Escape Codes for colors
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String cyan = '\x1B[36m';
  static const String magenta = '\x1B[35m';

  static void info(String message, [String name = 'INFO']) {
    print('[$name] $blue$message$reset');
  }

  static void success(String message, [String name = 'SUCCESS']) {
    print('[$name] $green$message$reset');
  }

  static void warning(String message, [String name = 'WARNING']) {
    print('[$name] $yellow$message$reset');
  }

  static void error(
    String message, [
    String name = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  ]) {
    String logMessage = '[$name] $red$message$reset';
    if (error != null) logMessage += '\nError: $error';
    if (stackTrace != null) logMessage += '\nStackTrace: $stackTrace';
    print(logMessage);
  }

  static void debug(String message, [String name = 'DEBUG']) {
    print('[$name] $magenta$message$reset');
  }

  static void nativeData(String channel, dynamic data) {
    print('[NATIVE] $cyan[NATIVE DATA - $channel]$reset $data');
  }
}
