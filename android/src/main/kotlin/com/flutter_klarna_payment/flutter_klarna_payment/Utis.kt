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

enum class KlarnaPaymentState {
    INITIAL,
    INITIALIZED,
    LOADED,
    AUTHORIZED,
    FINALIZED,
    REAUTHORIZED,
    ERROR_OCCURRED,
    LOAD_PAYMENT_REVIEW,
    UNKNOWN;
    fun toCamelCase(): String {
        val words = name.lowercase().split('_')
        val camelCaseWords = words.mapIndexed { index, word ->
            if (index == 0) word else word.replaceFirstChar{it.uppercase()}
        }
        return camelCaseWords.joinToString("")
    }

}
