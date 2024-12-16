import 'package:flutter/foundation.dart'; // For kReleaseMode

/// Secure Logger Class
class SecureLogger {
  // Singleton instance
  static final SecureLogger _instance = SecureLogger._internal();

  // Factory constructor for getting the singleton instance
  factory SecureLogger() {
    return _instance;
  }

  // Private constructor
  SecureLogger._internal();

  // Log Levels with ANSI color codes
  static const String _success = "\x1B[32mINFO\x1B[0m";     // Green
  static const String _debug = "\x1B[34mDEBUG\x1B[0m";   // Blue
  static const String _error = "\x1B[31mERROR\x1B[0m";   // Red

  // Control logging based on the environment (disable in production)
  bool _shouldLog() {
    return !kReleaseMode; // Log only in debug mode
  }

  // Generic log function with data masking, accepting any data type
  void _log(String level, Object? message, {Object? error, StackTrace? stackTrace}) {
    if (_shouldLog()) {
      String formattedMessage = _sanitizeMessage(message?.toString() ?? 'null');
      String logOutput = "[$level] $formattedMessage";

      if (error != null) {
        logOutput += " | Error: $error";
      }
      if (stackTrace != null) {
        logOutput += " | StackTrace: $stackTrace";
      }

      // Output the log with styling
      debugPrint(logOutput);
    }
  }

  // Sanitize sensitive data (for demonstration purposes)
  String _sanitizeMessage(String message) {
    // Replace sensitive data patterns (this is just an example)
    return message.replaceAll(RegExp(r'[0-9]{16}'), '**** **** **** ****'); // Masks credit card-like numbers
  }

  // Log info messages with any datatype
  void success(Object? message) {
    _log(_success, message);
  }

  // Log debug messages with any datatype
  void debug(Object? message) {
    _log(_debug, message);
  }

  // Log error messages with any datatype
  void error(Object? message, {Object? error, StackTrace? stackTrace}) {
    _log(_error, message, error: error, stackTrace: stackTrace);
  }
}
