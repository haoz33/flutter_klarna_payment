package com.flutter_klarna_payment.flutter_klarna_payment

data class KlarnaPayRequest(val clientToken: String, val returnUrl: String)

public fun convertToKlarnaPayRequest(map: Map<String?, Any?>?): KlarnaPayRequest? {
    if (map == null) {
        return null
    }

    val clientToken = map["clientToken"] as? String
    val returnUrl = map["returnUrl"] as? String

    if (clientToken != null && returnUrl != null) {
        return KlarnaPayRequest(clientToken, returnUrl)
    }

    return null // Return null if either clientToken or returnUrl is missing or not of the expected type.
}

