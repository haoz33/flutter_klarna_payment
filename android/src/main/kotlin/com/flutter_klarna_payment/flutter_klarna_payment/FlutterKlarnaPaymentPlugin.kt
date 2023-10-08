package com.flutter_klarna_payment.flutter_klarna_payment

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterKlarnaPaymentPlugin */
class FlutterKlarnaPaymentPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private val streamHandler = PaymentStreamHandler();

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_klarna_payment")
    channel.setMethodCallHandler(this)

    val paymentCallback = PaymentViewCallback(streamHandler)



    val eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "flutter_klarna_payment_event")
    eventChannel.setStreamHandler(streamHandler)

    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory("plugin.flutter_klarna_payment/view", PaymentViewFactory(messenger = flutterPluginBinding.binaryMessenger,paymentCallback))

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "pay") {
      streamHandler.pay()
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
