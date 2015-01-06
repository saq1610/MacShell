//
//  ProcessInfo.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class ProcessInfo: NSObject {
    var processName: String {
        get {
            return NSProcessInfo.processInfo().processName
        }
    }
    
    var processIdentifier: Int32 {
        get {
            return NSProcessInfo.processInfo().processIdentifier
        }
    }
    
    var processorCount: Int {
        get {
            return NSProcessInfo.processInfo().processorCount
        }
    }
    
    var activeProcessorCount: Int {
        get {
            return NSProcessInfo.processInfo().activeProcessorCount
        }
    }
    
    var hostName: String {
        get {
            return NSProcessInfo.processInfo().hostName
        }
    }
    
    var physicalMemory: UInt64 {
        get {
            return NSProcessInfo.processInfo().physicalMemory
        }
    }
    
    var systemUptime: Double {
        get {
            return NSProcessInfo.processInfo().systemUptime
        }
    }
    
    var globallyUniqueString: String {
        get {
            return NSProcessInfo.processInfo().globallyUniqueString
        }
    }
}

extension ProcessInfo: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessName")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessIdentifier")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getProcessorCount")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getActiveProcessorCount")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getHostName")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getOperatingSystemVersion")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getPhysicalMemory")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getSystemUptime")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getGloballyUniqueString")
    }
}

extension ProcessInfo: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "getProcessName":
            message.webView?.evaluateJavaScript("console.log('\(processName)')", completionHandler: nil)
            
        case "getProcessIdentifier":
            message.webView?.evaluateJavaScript("console.log(\(processIdentifier))", completionHandler: nil)
            
        case "getProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(processorCount))", completionHandler: nil)
            
        case "getActiveProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(activeProcessorCount))", completionHandler: nil)
            
        case "getHostName":
            message.webView?.evaluateJavaScript("console.log('\(hostName)')", completionHandler: nil)
            
        case "getOperatingSystemVersion":
            let osVersion = NSProcessInfo.processInfo().operatingSystemVersion
            let osVersionString = "{\"major\":\(osVersion.majorVersion),\"minor\":\(osVersion.minorVersion),\"patch\":\(osVersion.patchVersion)}";
            message.webView?.evaluateJavaScript("console.log(JSON.parse('\(osVersionString)'))", completionHandler: nil)
            
        case "getPhysicalMemory":
            message.webView?.evaluateJavaScript("console.log(\(physicalMemory))", completionHandler: nil)
            
        case "getSystemUptime":
            message.webView?.evaluateJavaScript("console.log(\(systemUptime))", completionHandler: nil)
            
        case "getGloballyUniqueString":
            message.webView?.evaluateJavaScript("console.log('\(globallyUniqueString)')", completionHandler: nil)
            
        default:
            break
        }
    }
}