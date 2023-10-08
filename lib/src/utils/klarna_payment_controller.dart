import 'package:flutter/services.dart';

class KlarnaPaymentController {
  KlarnaPaymentController.id(int id) {
    _eventChannel.receiveBroadcastStream().listen((event) {
      print("payment sheet state: $event");
    });
  }

  final _eventChannel = EventChannel('plugins.klarna_flutter/klarna');
}
