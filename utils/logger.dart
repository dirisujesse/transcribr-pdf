import 'dart:developer';

class AppLogger {
  static void info(dynamic data) {
    log(
      "MESSAGE -> \x1B[32m$data\x1B[0m",
      time: _now,
      name: "TRANSCRIBR<>INFO",
      level: 1,
    );
  }

  static DateTime get _now => DateTime.now();

  static void severe(dynamic message, {StackTrace? stackTrace, Object? error}) {
    log(
      "ERROR -> \x1B[31m$message\x1B[0m",
      time: _now,
      stackTrace: stackTrace,
      error: error,
      name: "TRANSCRIBR<>ERROR",
      level: 2,
    );
  }
}
