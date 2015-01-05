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
        switch message.name {
        case "getUserDefault":
            var result: AnyObject = getUserDefault(message.body as String)
            message.webView?.evaluateJavaScript("console.log('\(result.description)')", completionHandler: nil)
            break
        case "setUserDefault":
            var info = message.body as NSDictionary
            var key: String? = info.valueForKey("key") as? String
            var value: AnyObject? = info.valueForKey("value")
            if key != nil && value != nil {
                setUserDefault(key!, value: value!)
            }
            break
        default:
            break
        }
    }
    
    func setUserDefault(key: String, value: AnyObject) {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
    }
    
    func getUserDefault(key: String) -> AnyObject {
        if NSUserDefaults.standardUserDefaults().valueForKey(key) != nil {
            return NSUserDefaults.standardUserDefaults().valueForKey(key)!
        } else {
            return NSNull()
        }
    }
}