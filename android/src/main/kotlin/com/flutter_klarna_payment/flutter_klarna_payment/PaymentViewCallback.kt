package com.flutter_klarna_payment.flutter_klarna_payment

import com.klarna.mobile.sdk.api.payments.KlarnaPaymentView
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentViewCallback
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentsSDKError

class PaymentViewCallback(private  val streamHandler: PaymentStreamHandler) : KlarnaPaymentViewCallback {
    override fun onAuthorized(
        view: KlarnaPaymentView,
        approved: Boolean,
        authToken: String?,
        finalizedRequired: Boolean?
    ) {
        streamHandler.sendMessage("authed",null)
        println("callback debug: Authed")
        view.finalize(null)
    }

    override fun onErrorOccurred(view: KlarnaPaymentView, error: KlarnaPaymentsSDKError) {
        streamHandler.sendMessage("error",error.message)
        println("callback debug: error ${error.message}")

    }

    override fun onFinalized(view: KlarnaPaymentView, approved: Boolean, authToken: String?) {
        streamHandler.sendMessage("finalized",null)
        println("callback debug: finalized")

    }

    override fun onInitialized(view: KlarnaPaymentView) {
        streamHandler.sendMessage("initialized",null)
        streamHandler.setPaymentView(view)
        println("callback debug: initialized")

        view.load(null);
    }

    override fun onLoadPaymentReview(view: KlarnaPaymentView, showForm: Boolean) {
        streamHandler.sendMessage("loadedPaymentReview",null)
        view.loadPaymentReview();
    }

    override fun onLoaded(view: KlarnaPaymentView) {
        println("callback debug: loaded")

        streamHandler.sendMessage("loaded",null)

    }

    override fun onReauthorized(view: KlarnaPaymentView, approved: Boolean, authToken: String?) {
        println("callback debug: reauthorized")

        streamHandler.sendMessage("reauthorized",null)

    }

}