//
//  Window.swift
//  MacShell
//
//  Created by Florian Hämmerle on 2/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Window: NSObject {
    func setWindowTitle(window: NSWindow!, title: String) {
        window.title = title
    }
}

extension Window: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "setWindowTitle")
    }
}

extension Window: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "setWindowTitle":
            NSLog(message.webView?.window.
            message.webView?.evaluateJavaScript("console.log('setWindowTitle')", completionHandler: nil)
            
        default:
            break
        }
    }
}
