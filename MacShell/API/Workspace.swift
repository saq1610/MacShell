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
    func getRunningApplications() -> String {
        let runningApps = NSWorkspace.sharedWorkspace().runningApplications
        var result = "["
        var appNumber = 0
        for runningApp in runningApps {
            if appNumber > 0 {
                result += ","
            }
            appNumber++
            result += "{"
            result += "\"name\":\"\((runningApp as NSRunningApplication).localizedName!)\","
            result += "\"bundleUrl\":\"\((runningApp as NSRunningApplication).bundleURL!)\","
            result += "\"pid\":\((runningApp as NSRunningApplication).processIdentifier),"
            result += "\"bundleIdentifier\":\"\((runningApp as NSRunningApplication).bundleIdentifier!)\""
            result += "}"
        }
        result += "]"
        return result
    }
    
    func hideOtherApplications() {
        NSWorkspace.sharedWorkspace().hideOtherApplications()
    }
    
    func launchApplication(name: String) {
        NSWorkspace.sharedWorkspace().launchApplication(name)
    }
}

extension Workspace: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getRunningApplications")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "hideOtherApplications")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "launchApplication")
    }
}

extension Workspace: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "getRunningApplications":
            message.webView?.evaluateJavaScript("console.log(JSON.parse('\(getRunningApplications())'))", completionHandler: nil)
            
        case "hideOtherApplications":
            hideOtherApplications()
            
        case "launchApplication":
            launchApplication(message.body as String)
            
        default:
            break
        }
    }
}