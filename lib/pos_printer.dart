import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pos_printer/model/command.dart';

class PosPrinter {
  static const MethodChannel _channel = const MethodChannel('pos_printer');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool?> testPrint() async {
    try {
      await _channel.invokeMethod('testPrint');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool?> print(List<Command> commands) async {
    try {
      await _channel.invokeMethod(
          'print', commands.map((e) => e.toJson()).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}
