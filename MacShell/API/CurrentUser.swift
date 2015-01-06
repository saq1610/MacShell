//
//  CurrentUser.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class CurrentUser: NSObject {
    func getUserName() -> String {
        return NSUserName()
    }
    
    func getFullUserName() -> String {
        return NSFullUserName()
    }
}

extension CurrentUser: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getUserName")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getFullUserName")
    }
}

extension CurrentUser: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
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
}
