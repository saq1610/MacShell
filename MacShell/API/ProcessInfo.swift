//
//  ProcessInfo.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class ProcessInfo: NSObject, APIPackage {
    func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getProcessName")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getProcessIdentifier")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getProcessorCount")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getActiveProcessorCount")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getHostName")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getOperatingSystemVersion")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getPhysicalMemory")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getSystemUptime")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getGloballyUniqueString")
    }
    
    func processMessage(message: WKScriptMessage) {
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
        case "getGloballyUniqueString":
            message.webView?.evaluateJavaScript("console.log('\(NSProcessInfo.processInfo().globallyUniqueString)')", completionHandler: nil)
            break
        default:
            break
        }
    }
}