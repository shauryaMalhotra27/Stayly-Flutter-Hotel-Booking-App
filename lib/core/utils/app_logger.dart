import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// A centralized, lightweight logging utility.
/// Logs are only emitted in debug mode.
class AppLogger {
  AppLogger._();

  static void debug(String message, {String? name, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: name ?? 'DEBUG', error: error, stackTrace: stackTrace, level: 500);
    }
  }

  static void info(String message, {String? name}) {
    if (kDebugMode) {
      developer.log(message, name: name ?? 'INFO', level: 800);
    }
  }

  static void warning(String message, {String? name, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: name ?? 'WARNING', error: error, stackTrace: stackTrace, level: 900);
    }
  }

  static void error(String message, {String? name, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: name ?? 'ERROR', error: error, stackTrace: stackTrace, level: 1000);
    }
  }
}

