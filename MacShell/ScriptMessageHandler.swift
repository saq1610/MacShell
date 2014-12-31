//
//  ScriptMessageHandler.swift
//  MacShell
//
//  Created by Florian Hämmerle on 12/29/14.
//  Copyright (c) 2014 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class ScriptMessageHandler : NSObject, WKScriptMessageHandler {
    var webView: WKWebView!
    
    init(webView: WKWebView!) {
        self.webView = webView
    }
    
    func publishAPIToWebView() {
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessName")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessIdentifier")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessorCount")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getHostName")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getUserName")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getFullUserName")
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch (message.name) {
        case "getProcessName":
            message.webView?.evaluateJavaScript("console.log('\(NSProcessInfo.processInfo().processName)')", completionHandler: nil)
            break
        case "getProcessIdentifier":
            message.webView?.evaluateJavaScript("console.log(\(NSProcessInfo.processInfo().processIdentifier))", completionHandler: nil)
            break
        case "getProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(NSProcessInfo.processInfo().processorCount))", completionHandler: nil)
            break
        case "getHostName":
            message.webView?.evaluateJavaScript("console.log('\(NSProcessInfo.processInfo().hostName)')", completionHandler: nil)
            break
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