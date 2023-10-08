package com.flutter_klarna_payment.flutter_klarna_payment

import android.content.Context
import android.view.View
import com.klarna.mobile.sdk.api.KlarnaLoggingLevel
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentView
import com.klarna.mobile.sdk.api.payments.KlarnaPaymentViewCallback
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class PaymentView(context: Context, messenger: BinaryMessenger, id: Int, creationParams: Map<String?, Any?>?,private val paymentViewCallback: KlarnaPaymentViewCallback): PlatformView {

    private  val context: Context =context
    private val paymentView: KlarnaPaymentView


    override fun getView(): View {
        return paymentView
    }

    override fun dispose() {
    }

    init
    {

        val klarnaRequest = convertToKlarnaPayRequest(creationParams)
            ?: throw NullPointerException("Value is null")

        paymentView = KlarnaPaymentView(
            context = context,
            category = "klarna",
            callback = paymentViewCallback,
            returnURL = klarnaRequest.returnUrl
        )

        paymentView.registerPaymentViewCallback(paymentViewCallback)

        paymentView.loggingLevel = KlarnaLoggingLevel.Error

        paymentView.initialize(klarnaRequest.clientToken,klarnaRequest.returnUrl)

    }



    fun pay(){
        paymentView.authorize(false,null)
    }





}