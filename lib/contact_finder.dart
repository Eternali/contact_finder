import 'dart:async';

import 'package:flutter/services.dart';

class ContactFinder {
  static const MethodChannel _channel =
      const MethodChannel('contact_finder');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
