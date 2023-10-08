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

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
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
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    @IBOutlet weak var heightConstr: NSLayoutConstraint!
	
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        
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
        
        let streamHandler = PaymentStreamHandler()
        
        let callback = PaymentViewCallback(streamHandler: streamHandler)
        
        let paymentView = KlarnaPaymentView(category: "klarna", eventListener: callback)
        
        paymentView.initialize(clientToken: request.clientToken, returnUrl:URL.init(string: request.returnUrl)!)
        
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightConstr = paymentView.heightAnchor.constraint(equalToConstant: 0)
        heightConstr.isActive = true
        paymentView.backgroundColor = UIColor.lightGray
        _view.addSubview(paymentView)
        _view.addConstraint(heightConstr);
        
        
        callback.setHeightConstr(heightConstr: self.heightConstr)


    
    }
}

