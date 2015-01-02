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
    func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getUserName")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getFullUserName")
    }
    
    func processMessage(message: WKScriptMessage) {
        switch (message.name) {
        case "getUserName":
            message.webView?.evaluateJavaScript("console.log('\(getUserName())')", completionHandler: nil)
            break
        case "getFullUserName":
            message.webView?.evaluateJavaScript("console.log('\(getFullUserName())')", completionHandler: nil)
            break
        default:
            break
        }
    }
    
    func getUserName() -> String {
        return NSUserName()
    }
    
    func getFullUserName() -> String {
        return NSFullUserName()
    }
}
