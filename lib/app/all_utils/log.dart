import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(dynamic value) {
    if (kDebugMode) {
      dev.log("""


$value


""");
    }
  }
}
