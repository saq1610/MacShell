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
            if let title = message.webView?.window?.title {
                let wndTitle = message.body as String
                setWindowTitle(message.webView?.window!, title: wndTitle)
                message.webView?.evaluateJavaScript("console.log('setWindowTitle(\"\(wndTitle)\")')", completionHandler: nil)
            } else {
                message.webView?.evaluateJavaScript("console.log('setWindowTitle not possible')", completionHandler: nil)
            }
            
        default:
            break
        }
    }
}
