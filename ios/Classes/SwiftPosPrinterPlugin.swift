import Flutter
import UIKit

public class SwiftPosPrinterPlugin: NSObject, FlutterPlugin {
    static let bluetoothPrinterManager = BluetoothPrinterManager()
    static let progressView = ProgressBarViewController.default;
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pos_printer", binaryMessenger: registrar.messenger())
    let instance = SwiftPosPrinterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "isSunmiPrinter":
        result("false")
    case "testPrint":
        PrinterUtil.testPrint()
    case "print":
        print(call.arguments ?? "")
        
        if let json = call.arguments as? String {
            PrinterUtil.printReceiptJSON(commandsJSON: json)
        }
        
    default:
        print("not Implemented")
    }
  }
}
