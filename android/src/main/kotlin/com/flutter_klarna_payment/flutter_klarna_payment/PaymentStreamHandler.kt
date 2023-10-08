package com.flutter_klarna_payment.flutter_klarna_payment

import com.klarna.mobile.sdk.api.payments.KlarnaPaymentView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler

class PaymentStreamHandler() : StreamHandler {

    private var paymentView: KlarnaPaymentView? = null;
    private var sink : EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        sendMessage(KlarnaPaymentState.INITIAL.toCamelCase(),null)
    }

    override fun onCancel(arguments: Any?) {
        sink = null;
    }

    fun setPaymentView(pv:KlarnaPaymentView){
        paymentView=pv;
    }

    fun sendMessage(state:String, message:String?){
        sink?.success(mapOf("state" to state, "message" to message));
    }

    fun pay(){
        if (paymentView!=null){
            paymentView!!.authorize(false,null)
        }
    }
}