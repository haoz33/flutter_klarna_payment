import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';
import 'package:flutter_klarna_payment/src/controller/klarna_payment_controller_state.dart';

class KlarnaPaymentController {
  KlarnaPaymentController() {
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      _updateState(event['state'], event['message']);
      state = KlarnaPaymentControllerState(
          state: event['state'], message: event['message']);
    });
  }

  final _eventChannel = const EventChannel("flutter_klarna_payment_event");

  final _flutterKlarnaPaymentPlugin = FlutterKlarnaPayment();

  late final StreamSubscription _subscription;

  KlarnaPaymentControllerState state =
      const KlarnaPaymentControllerState(state: '');

  void pay() {
    _flutterKlarnaPaymentPlugin.pay();
  }

  void dispose() {
    _subscription.cancel();
    _stateController.close();
  }

  final _stateController = StreamController<KlarnaPaymentControllerState>();

  Stream<KlarnaPaymentControllerState> get stateStream =>
      _stateController.stream;

  void _updateState(String state, String? message) {
    final newState =
        KlarnaPaymentControllerState(state: state, message: message);
    _stateController.sink.add(newState);
  }
}