package com.flutter_klarna_payment.flutter_klarna_payment

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PaymentViewFactory(private val messenger: BinaryMessenger,private  val paymentViewCallback: PaymentViewCallback):PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return PaymentView(context,messenger, viewId, creationParams,paymentViewCallback)
    }

}