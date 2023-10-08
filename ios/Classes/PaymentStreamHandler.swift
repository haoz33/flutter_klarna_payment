//
//  PaymentStreamHandler.swift
//  flutter_klarna_payment
//
//  Created by qaq on 08/10/2023.
//

import Flutter
import KlarnaMobileSDK

class PaymentStreamHandler: NSObject, FlutterStreamHandler {
    private var paymentView: KlarnaPaymentView?
    private var sink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }

    func setPaymentView(_ pv: KlarnaPaymentView) {
        paymentView = pv
    }

    func sendMessage(state: String, message: String?) {
        sink?(["state": state, "message": message ?? ""])
    }

    func pay() {
        if let paymentView = paymentView {
            paymentView.authorize()
        }
    }
}
