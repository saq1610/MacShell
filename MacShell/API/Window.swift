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
    
    func getRepresentedFilename(window: NSWindow!) -> String {
        return window.representedFilename
    }
    
    func setRepresentedFilename(window: NSWindow!, representedFilename: String) {
        window.representedFilename = representedFilename
    }
}

extension Window: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "setWindowTitle")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getRepresentedFilename")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "setRepresentedFilename")
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
        
        case "getRepresentedFilename":
            message.webView?.evaluateJavaScript("console.log('\(getRepresentedFilename(message.webView?.window))')", completionHandler: nil)
            
        case "setRepresentedFilename":
            if let filename = message.body as? String {
                setRepresentedFilename(message.webView?.window, representedFilename: filename)
                message.webView?.evaluateJavaScript("console.log('setRepresentedFilename succeeded')", completionHandler: nil)
            } else {
                message.webView?.evaluateJavaScript("console.log('setRepresentedFilename failed')", completionHandler: nil)
            }
            
        default:
            break
        }
    }
}
