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
    
    var apiPackages: [APIPackage] = [
        CurrentUser(),
        Dock(),
        FileSystem(),
        Menu(),
        ProcessInfo(),
        Tray(),
        UserDefaults(),
        Workspace()
    ]
    
    init(webView: WKWebView!) {
        self.webView = webView
    }
    
    func publishAPIToWebView() {
        for apiPackage in apiPackages {
            apiPackage.registerMethods(self, webView: self.webView)
        }
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        for apiPackage in apiPackages {
            apiPackage.processMessage(message)
        }
    }
}