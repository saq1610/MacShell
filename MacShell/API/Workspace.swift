//
//  Workspace.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Workspace: NSObject, APIPackage {
    
    class func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getRunningApplications")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "hideOtherApplications")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "launchApplication")
    }
    
    class func processMessage(message: WKScriptMessage) {
        switch (message.name) {
        case "getRunningApplications":
            var runningApps = NSWorkspace.sharedWorkspace().runningApplications
            var result = "["
            var appNumber = 0
            for runningApp in runningApps {
                if appNumber > 0 { result += "," }
                appNumber++
                result += "{"
                result += "\"name\":\"\((runningApp as NSRunningApplication).localizedName!)\","
                result += "\"bundleUrl\":\"\((runningApp as NSRunningApplication).bundleURL!)\","
                result += "\"pid\":\((runningApp as NSRunningApplication).processIdentifier),"
                result += "\"bundleIdentifier\":\"\((runningApp as NSRunningApplication).bundleIdentifier!)\""
                result += "}"
            }
            result += "]"
            message.webView?.evaluateJavaScript("console.log(JSON.parse('\(result)'))", completionHandler: nil)
            break
        case "hideOtherApplications":
            NSWorkspace.sharedWorkspace().hideOtherApplications()
            break
        case "launchApplication":
            NSWorkspace.sharedWorkspace().launchApplication(message.body as String)
            break
        default:
            break
        }
    }
}