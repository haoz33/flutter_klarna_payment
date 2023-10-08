class KlarnaPaymentControllerState {
  final String state;
  final String? message;
  const KlarnaPaymentControllerState({required this.state, this.message});

  @override
  String toString() {
    return 'state: $state, message: $message';
  }
}
