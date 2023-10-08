//
//  PaymentViewCallback.swift
//  flutter_klarna_payment
//
//  Created by qaq on 08/10/2023.
//

import Foundation

import KlarnaMobileSDK


class PaymentViewCallback: KlarnaPaymentEventListener {
    private var heightConstr: NSLayoutConstraint?
    private let streamHandler: PaymentStreamHandler

    init(streamHandler:PaymentStreamHandler){
        self.streamHandler=streamHandler
    }
    
    func setHeightConstr(heightConstr:NSLayoutConstraint){
        self.heightConstr = heightConstr
    }
    
    func klarnaResized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, to newHeight: CGFloat) {
        
        heightConstr?.constant=newHeight
        
    }
    
    
    
    func klarnaInitialized(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
        streamHandler.sendMessage(state: "initialized", message: nil);
         paymentView.load(jsonData: nil)
        streamHandler.setPaymentView(paymentView)
     }
     
     func klarnaLoaded(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
         streamHandler.sendMessage(state:"loaded", message: nil as String?);
     }
     
     func klarnaLoadedPaymentReview(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
         
         
         streamHandler.sendMessage(state:"paymentReview", message: nil);
     }
     
     func klarnaAuthorized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?, finalizeRequired: Bool) {
         if (authToken != nil) {
             streamHandler.sendMessage(state:"authorized", message: authToken);

         }
     }
     
     func klarnaReauthorized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?) {
         streamHandler.sendMessage(state:"reauthorized", message: nil);

     }
     
     func klarnaFinalized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?) {
         streamHandler.sendMessage(state:"finalized", message: nil);

     }
     
     func klarnaFailed(inPaymentView paymentView: KlarnaMobileSDK.KlarnaPaymentView, withError error: KlarnaMobileSDK.KlarnaPaymentError) {
         streamHandler.sendMessage(state:"failed", message: error.message);

         
     }
    
}
