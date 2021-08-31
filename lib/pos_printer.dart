import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pos_printer/bluetooth_printer.dart';

class PosPrinter {
  static const MethodChannel _channel = const MethodChannel('pos_printer');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // static Future<bool?> get isBuildInPrinter async {
  //   final bool? isBuildInPrinter = await _channel.invokeMethod('isBuildInPrinter');
  //   return isBuildInPrinter;
  // }

  // static Future<bool?> get printer async {
  //   final bool? isBuildInPrinter = await _channel.invokeMethod('isBuildInPrinter');
  //   return isBuildInPrinter;
  // }

  static Future<bool?> testPrint() async {
    try {
      await _channel.invokeMethod('testPrint');
      return true;
    } catch (e) {
      return false;
    }
  }
}
