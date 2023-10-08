import Flutter
import UIKit

public class FlutterKlarnaPaymentPlugin: NSObject, FlutterPlugin {
    
    static var streamHandler = PaymentStreamHandler()

    public static func register(with registrar: FlutterPluginRegistrar) {
        
        //Method Channel
        let channel = FlutterMethodChannel(name: "flutter_klarna_payment", binaryMessenger: registrar.messenger())
        let instance = FlutterKlarnaPaymentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    
        // Native View
        
        let factory = FLNativeViewFactory(messenger: registrar.messenger(),streamHandler: streamHandler)
        registrar.register(factory, withId: "plugin.flutter_klarna_payment/view")
        
        
        // Event Channel
        let klarnaChannel = FlutterEventChannel(name: "flutter_klarna_payment_event",
                                                binaryMessenger: registrar.messenger())
        
        klarnaChannel.setStreamHandler(streamHandler)

        
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "pay":
        FlutterKlarnaPaymentPlugin.streamHandler.pay()
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
