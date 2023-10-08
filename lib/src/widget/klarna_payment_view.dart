import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_klarna_payment/src/controller/klarna_payment_controller.dart';
import 'package:flutter_klarna_payment/src/utils/klarna_payment_request.dart';

const String _viewType = 'plugin.flutter_klarna_payment/view';

class KlarnaPaymentView extends StatelessWidget {
  const KlarnaPaymentView(
      {Key? key, required this.request, required this.controller})
      : super(key: key);

  final KlarnaPaymentRequest request;
  final KlarnaPaymentController controller;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: _viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: request.toCreationParams(),
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return AndroidView(
      viewType: _viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: request.toCreationParams(),
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
