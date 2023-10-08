//
//  Utils.swift
//  flutter_klarna_payment
//
//  Created by qaq on 08/10/2023.
//

import Foundation

struct KlarnaPayRequest {
    let clientToken: String
    let returnUrl: String
}

func convertToKlarnaPayRequest(input: Any?) -> KlarnaPayRequest? {
    guard let inputDict = input as? [String: Any],
        let clientToken = inputDict["clientToken"] as? String,
        let returnUrl = inputDict["returnUrl"] as? String else {
            return nil
    }
    
    return KlarnaPayRequest(clientToken: clientToken, returnUrl: returnUrl)
}


enum PaymentState: String {
    case initial
    case initialized
    case loaded
    case authorized
    case finalized
    case reauthorized
    case errorOccurred
    case loadPaymentReview
    case unknown
}
