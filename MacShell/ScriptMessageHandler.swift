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
        // ProcessInfo API
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessName")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessIdentifier")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessorCount")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getActiveProcessorCount")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getHostName")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getOperatingSystemVersion")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getPhysicalMemory")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getSystemUptime")
                
        // User API
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
        case "getActiveProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(NSProcessInfo.processInfo().activeProcessorCount))", completionHandler: nil)
            break
        case "getHostName":
            message.webView?.evaluateJavaScript("console.log('\(NSProcessInfo.processInfo().hostName)')", completionHandler: nil)
            break
        case "getOperatingSystemVersion":
            var osVersion = NSProcessInfo.processInfo().operatingSystemVersion
            var osVersionString = "{\"major\":\(osVersion.majorVersion),\"minor\":\(osVersion.minorVersion),\"patch\":\(osVersion.patchVersion)}";
            message.webView?.evaluateJavaScript("console.log(JSON.parse('\(osVersionString)'))", completionHandler: nil)
            break;
        case "getPhysicalMemory":
            message.webView?.evaluateJavaScript("console.log(\(NSProcessInfo.processInfo().physicalMemory))", completionHandler: nil)
            break
        case "getSystemUptime":
            message.webView?.evaluateJavaScript("console.log(\(NSProcessInfo.processInfo().systemUptime))", completionHandler: nil)
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