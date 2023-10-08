import 'package:flutter_klarna_payment/src/utils/klarna_state.dart';

class KlarnaPaymentControllerState {
  final KlarnaState state;
  final String? message;
  const KlarnaPaymentControllerState({required this.state, this.message});

  @override
  String toString() {
    return 'state: $state, message: $message';
  }
}
