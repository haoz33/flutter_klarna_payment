import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment_platform_interface.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterKlarnaPaymentPlatform
    with MockPlatformInterfaceMixin
    implements FlutterKlarnaPaymentPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterKlarnaPaymentPlatform initialPlatform = FlutterKlarnaPaymentPlatform.instance;

  test('$MethodChannelFlutterKlarnaPayment is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKlarnaPayment>());
  });

  test('getPlatformVersion', () async {
    FlutterKlarnaPayment flutterKlarnaPaymentPlugin = FlutterKlarnaPayment();
    MockFlutterKlarnaPaymentPlatform fakePlatform = MockFlutterKlarnaPaymentPlatform();
    FlutterKlarnaPaymentPlatform.instance = fakePlatform;

    expect(await flutterKlarnaPaymentPlugin.getPlatformVersion(), '42');
  });
}
