import 'dart:developer';

import 'package:flutter/foundation.dart';

class LoggerHelper {
  static void printMessage(String message, {String? tag}) {
    if (kDebugMode) {
      log(message, name: tag ?? 'LoggerHelper');
    }
  }
}
