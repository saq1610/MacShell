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
        switch message.name {
        case "getProcessName":
            message.webView?.evaluateJavaScript("console.log('\(processName)')", completionHandler: nil)
            break
        case "getProcessIdentifier":
            message.webView?.evaluateJavaScript("console.log(\(processIdentifier))", completionHandler: nil)
            break
        case "getProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(processorCount))", completionHandler: nil)
            break
        case "getActiveProcessorCount":
            message.webView?.evaluateJavaScript("console.log(\(activeProcessorCount))", completionHandler: nil)
            break
        case "getHostName":
            message.webView?.evaluateJavaScript("console.log('\(hostName)')", completionHandler: nil)
            break
        case "getOperatingSystemVersion":
            let osVersion = NSProcessInfo.processInfo().operatingSystemVersion
            let osVersionString = "{\"major\":\(osVersion.majorVersion),\"minor\":\(osVersion.minorVersion),\"patch\":\(osVersion.patchVersion)}";
            message.webView?.evaluateJavaScript("console.log(JSON.parse('\(osVersionString)'))", completionHandler: nil)
            break;
        case "getPhysicalMemory":
            message.webView?.evaluateJavaScript("console.log(\(physicalMemory))", completionHandler: nil)
            break
        case "getSystemUptime":
            message.webView?.evaluateJavaScript("console.log(\(systemUptime))", completionHandler: nil)
            break
        case "getGloballyUniqueString":
            message.webView?.evaluateJavaScript("console.log('\(globallyUniqueString)')", completionHandler: nil)
            break
        default:
            break
        }
    }
    
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