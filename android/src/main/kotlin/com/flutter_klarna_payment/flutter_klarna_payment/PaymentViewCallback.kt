package com.flutter_klarna_payment.flutter_klarna_payment

import com.klarna.mobile.sdk.api.payments.KlarnaPaymentView
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentViewCallback
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentsSDKError

class PaymentViewCallback(private val streamHandler: PaymentStreamHandler) : KlarnaPaymentViewCallback {
    override fun onAuthorized(
        view: KlarnaPaymentView,
        approved: Boolean,
        authToken: String?,
        finalizedRequired: Boolean?
    ) {
        streamHandler.sendMessage(KlarnaPaymentState.AUTHORIZED.toCamelCase(),null)
        view.finalize(null)
    }

    override fun onErrorOccurred(view: KlarnaPaymentView, error: KlarnaPaymentsSDKError) {
        streamHandler.sendMessage(KlarnaPaymentState.ERROR_OCCURRED.toCamelCase(),error.message)
    }

    override fun onFinalized(view: KlarnaPaymentView, approved: Boolean, authToken: String?) {
        streamHandler.sendMessage(KlarnaPaymentState.FINALIZED.toCamelCase(),null)
    }

    override fun onInitialized(view: KlarnaPaymentView) {
        streamHandler.sendMessage(KlarnaPaymentState.INITIALIZED.toCamelCase(),null)
        streamHandler.setPaymentView(view)
        view.load(null);
    }

    override fun onLoadPaymentReview(view: KlarnaPaymentView, showForm: Boolean) {
        streamHandler.sendMessage(KlarnaPaymentState.LOAD_PAYMENT_REVIEW.toCamelCase(),null)
        view.loadPaymentReview();
    }

    override fun onLoaded(view: KlarnaPaymentView) {
        streamHandler.sendMessage(KlarnaPaymentState.LOADED.toCamelCase(),null)

    }

    override fun onReauthorized(view: KlarnaPaymentView, approved: Boolean, authToken: String?) {
        streamHandler.sendMessage(KlarnaPaymentState.REAUTHORIZED.toCamelCase(),null)
    }

}