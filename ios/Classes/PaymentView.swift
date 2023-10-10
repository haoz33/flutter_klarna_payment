//
//  PaymentView.swift
//  flutter_klarna_payment
//
//  Created by qaq on 08/10/2023.
//

import Foundation
import Flutter
import UIKit

import KlarnaMobileSDK

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var streamHandler: PaymentStreamHandler
    
    init(messenger: FlutterBinaryMessenger,streamHandler:PaymentStreamHandler) {
        self.messenger = messenger
        self.streamHandler=streamHandler
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            streamHandler:  streamHandler
        )
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView,KlarnaPaymentEventListener {
    private var _view: UIView
    @IBOutlet weak var heightConstr: NSLayoutConstraint!
    private var _paymentView: KlarnaPaymentView?
    private var streamHandler: PaymentStreamHandler

    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        streamHandler:PaymentStreamHandler
    ) {
        self.streamHandler=streamHandler

        _view = UIView()
        super.init()
        // iOS views can be created here

        let data = convertToKlarnaPayRequest(input: args)
        createNativeView(view: _view,request: data!)
    }

    func view() -> UIView {
        return _view
    }
    


    func createNativeView(view _view: UIView, request:KlarnaPayRequest){
        streamHandler.sendMessage(state: PaymentState.initial.rawValue, message: nil);

        _paymentView = KlarnaPaymentView(category: "klarna", eventListener: self)
        // Create a height constraint that we'll update as its height changes.
        _paymentView!.initialize(clientToken: request.clientToken, returnUrl:URL.init(string: request.returnUrl)!)

        _paymentView!.translatesAutoresizingMaskIntoConstraints = false
        self.heightConstr = _paymentView!.heightAnchor.constraint(equalToConstant: 0)
        heightConstr.isActive = true
        _paymentView!.backgroundColor = UIColor.lightGray
        _view.addSubview(_paymentView!)
        _view.addConstraint(heightConstr);
        
        _paymentView!.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: _paymentView!, attribute: $0, relatedBy: .equal, toItem: _paymentView!.superview, attribute: $0, multiplier: 1, constant: 0)
        })
    
    }
    
    
    
    func klarnaInitialized(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
        streamHandler.sendMessage(state: PaymentState.initialized.rawValue, message: nil);
        paymentView.load(jsonData: nil)
        streamHandler.setPaymentView(paymentView)
    }
    
    func klarnaLoaded(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
        streamHandler.sendMessage(state:PaymentState.loaded.rawValue, message: nil as String?);
    }
    
    func klarnaLoadedPaymentReview(paymentView: KlarnaMobileSDK.KlarnaPaymentView) {
        streamHandler.sendMessage(state:PaymentState.loadPaymentReview.rawValue, message: nil);
    }
    
    func klarnaAuthorized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?, finalizeRequired: Bool) {
        if (authToken != nil) {
            streamHandler.sendMessage(state:PaymentState.authorized.rawValue, message: authToken);
            
        }
    }
    
    func klarnaReauthorized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?) {
        
        streamHandler.sendMessage(state:PaymentState.reauthorized.rawValue, message: nil);
    }
    
    func klarnaFinalized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, approved: Bool, authToken: String?) {
        streamHandler.sendMessage(state:PaymentState.finalized.rawValue, message: nil);
    }
    
    func klarnaResized(paymentView: KlarnaMobileSDK.KlarnaPaymentView, to newHeight: CGFloat) {
        self.heightConstr.constant = newHeight
    }
    
    func klarnaFailed(inPaymentView paymentView: KlarnaMobileSDK.KlarnaPaymentView, withError error: KlarnaMobileSDK.KlarnaPaymentError) {
        streamHandler.sendMessage(state:PaymentState.errorOccurred.rawValue, message: error.message);

    }
}

