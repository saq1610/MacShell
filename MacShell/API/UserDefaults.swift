//
//  UserDefaults.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class UserDefaults: NSObject {
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

extension UserDefaults: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "setUserDefault")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "getUserDefault")
    }
}

extension UserDefaults: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "getUserDefault":
            if let key: String = message.body as? String {
                message.webView?.evaluateJavaScript("console.log('\(getUserDefault(key).description)')", completionHandler: nil)
            }
            break
        case "setUserDefault":
            if let info = message.body as? NSDictionary {
                if let key = info.valueForKey("key") as? String {
                    if let value: AnyObject = info.valueForKey("value") {
                        setUserDefault(key, value: value)
                    }
                }
            }
            break
        default:
            break
        }
    }
}