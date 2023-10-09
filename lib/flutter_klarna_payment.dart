// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'src/flutter_klarna_payment_platform_interface.dart';
export './src/utils/klarna_payment_request.dart';
export './src/widget/klarna_payment_view.dart';
export 'src/controller/klarna_payment_controller.dart';
export './src/utils/klarna_state.dart';

class FlutterKlarnaPayment {
  Future<void> pay() {
    return FlutterKlarnaPaymentPlatform.instance.pay();
  }
}
