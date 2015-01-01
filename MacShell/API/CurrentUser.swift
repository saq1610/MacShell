//
//  CurrentUser.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class CurrentUser: NSObject, APIPackage {
    class func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getUserName")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getFullUserName")
    }
    
    class func processMessage(message: WKScriptMessage) {
        switch (message.name) {
        case "getUserName":
            message.webView?.evaluateJavaScript("console.log('\(NSUserName())')", completionHandler: nil)
            break
        case "getFullUserName":
            message.webView?.evaluateJavaScript("console.log('\(NSFullUserName())')", completionHandler: nil)
            break
        default:
            break
        }
    }
}
