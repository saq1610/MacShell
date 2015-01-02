//
//  UserDefaults.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class UserDefaults: NSObject, APIPackage {
    func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "setUserDefault")
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "getUserDefault")
    }
    
    func processMessage(message: WKScriptMessage) {
        switch (message.name) {
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
        default:
            break
        }
    }
}