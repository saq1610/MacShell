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
        CurrentUser.registerMethods(self, webView: self.webView)
        ProcessInfo.registerMethods(self, webView: self.webView)
        Workspace.registerMethods(self, webView: self.webView)
        
        // UserDefaults API
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "setUserDefault")
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "getUserDefault")
        
        // Dock API
        self.webView.configuration.userContentController.addScriptMessageHandler(self, name: "setDockTileBadge")
        
        // User API
        
        
        // FileSystem API
        
        // Menu API
        
        // Tray API
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch (message.name) {
        
        
        case "getGloballyUniqueString":
            message.webView?.evaluateJavaScript("console.log('\(NSProcessInfo.processInfo().globallyUniqueString)')", completionHandler: nil)
            break
            
        case "getUserDefault":
            var info = message.body as NSDictionary
            var type: AnyObject? = info.valueForKey("type")
            var key: String = info.valueForKey("key") as String
            var result: String?
            switch (type as String) {
                case "bool":
                    result = NSUserDefaults.standardUserDefaults().boolForKey(key).description
                    break
                case "double":
                    result = NSUserDefaults.standardUserDefaults().doubleForKey(key).description
                    break
                case "dictionary":
                    result = NSUserDefaults.standardUserDefaults().dictionaryForKey(key)?.description
                    break
                case "int":
                    result = NSUserDefaults.standardUserDefaults().integerForKey(key).description
                    break
                case "string":
                    result = NSUserDefaults.standardUserDefaults().stringForKey(key)
                    break
                default:
                    break
            }
            message.webView?.evaluateJavaScript("console.log('\(result)')", completionHandler: nil)
            break
        case "setUserDefault":
            var info = message.body as NSDictionary
            var type: AnyObject? = info.valueForKey("type")
            var key: String = info.valueForKey("key") as String
            var value: AnyObject? = info.valueForKey("value")
            var result: String?
            NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
            break
        
        case "setDockTileBadge":
            NSApplication.sharedApplication().dockTile.badgeLabel = ((message.body as NSDictionary).valueForKey("label") as String)
            break
            
        
        default:
            CurrentUser.processMessage(message)
            ProcessInfo.processMessage(message)
            Workspace.processMessage(message)
            break
        }
    }
    
}