class KlarnaPaymentRequest {
  final String clientToken;
  final String returnUrl;

  KlarnaPaymentRequest({required this.clientToken, required this.returnUrl});

  Map<String, String> toCreationParams() {
    return {'clientToken': clientToken, 'returnUrl': returnUrl};
  }
}
