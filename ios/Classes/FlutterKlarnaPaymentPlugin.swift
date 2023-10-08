import Flutter
import UIKit

public class FlutterKlarnaPaymentPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_klarna_payment", binaryMessenger: registrar.messenger())
        let instance = FlutterKlarnaPaymentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "plugin.flutter_klarna_payment/view")

        
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
