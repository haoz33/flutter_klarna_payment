import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_klarna_payment/src/utils/klarna_payment_request.dart';

const String _viewType = 'plugin.flutter_klarna_payment/view';

class KlarnaPaymentView extends StatelessWidget {
  const KlarnaPaymentView({Key? key, required this.request}) : super(key: key);

  final KlarnaPaymentRequest request;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Text('ABC');
    }

    return AndroidView(
      viewType: _viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: request.toCreationParams(),
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
