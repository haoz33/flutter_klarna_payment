import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';
import 'package:flutter_klarna_payment/src/controller/klarna_payment_controller_state.dart';

class KlarnaPaymentController {
  KlarnaPaymentController() {
    _subscription = _eventChannel.receiveBroadcastStream().listen((event) {
      _updateState(event['state'], event['message']);
    });
  }

  final _eventChannel = const EventChannel("flutter_klarna_payment_event");

  final _flutterKlarnaPaymentPlugin = FlutterKlarnaPayment();

  late final StreamSubscription _subscription;

  void pay() {
    _flutterKlarnaPaymentPlugin.pay();
  }

  void dispose() {
    _subscription.cancel();
    _stateController.close();
  }

  final _stateController = StreamController<KlarnaPaymentControllerState>();

  KlarnaPaymentControllerState _currentState =
      const KlarnaPaymentControllerState(state: KlarnaState.unknown);

  // ignore: unnecessary_getters_setters
  KlarnaPaymentControllerState get currentState => _currentState;

  Stream<KlarnaPaymentControllerState> get stateStream =>
      _stateController.stream;

  set currentState(KlarnaPaymentControllerState state) {
    _currentState = state;
  }

  void _updateState(String state, String? message) {
    final newState = KlarnaPaymentControllerState(
        state: klarnaStateFromString(state), message: message);
    _stateController.sink.add(newState);
    currentState = newState;
  }
}
