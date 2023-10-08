import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_klarna_payment_platform_interface.dart';

/// An implementation of [FlutterKlarnaPaymentPlatform] that uses method channels.
class MethodChannelFlutterKlarnaPayment extends FlutterKlarnaPaymentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_klarna_payment');

  @override
  Future<void> pay() async {
    await methodChannel.invokeMethod<String>('pay');
  }
}
