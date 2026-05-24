import '../../config/env/env_config.dart';

class AppLogger {
  AppLogger._();

  static void log(String message) {
    if (EnvConfig.enableLogging) {
      // ignore: avoid_print
      print('[BeautyGoVN] $message');
    }
  }
}
