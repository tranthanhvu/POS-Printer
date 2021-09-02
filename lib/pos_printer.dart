import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pos_printer/model/command.dart';

class PosPrinter {
  static const kPrinterDensity = 384;
  static const kFontDensityNormal = 12;
  static const kFontDensitySmall = 9;
  static const kPrintTextSmallLength = kPrinterDensity / kFontDensitySmall;
  static const kPrintTextNormalLength = kPrinterDensity / kFontDensityNormal;
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
      final json = commands.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(json);
      await _channel.invokeMethod('print', jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
