import 'dart:developer' as developer;


class UtilLogger {
  static const String TAG = "RotationApp";

  static log([String tag = TAG, dynamic msg]) {
    if (true) {
      developer.log('$msg', name: tag);
    }
  }

  ///Singleton factory
  static final UtilLogger _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
