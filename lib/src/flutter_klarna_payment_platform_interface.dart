import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_klarna_payment_method_channel.dart';

abstract class FlutterKlarnaPaymentPlatform extends PlatformInterface {
  /// Constructs a FlutterKlarnaPaymentPlatform.
  FlutterKlarnaPaymentPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterKlarnaPaymentPlatform _instance =
      MethodChannelFlutterKlarnaPayment();

  /// The default instance of [FlutterKlarnaPaymentPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterKlarnaPayment].
  static FlutterKlarnaPaymentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterKlarnaPaymentPlatform] when
  /// they register themselves.
  static set instance(FlutterKlarnaPaymentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> pay() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
