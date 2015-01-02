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
        Dock.registerMethods(self, webView: self.webView)
        FileSystem.registerMethods(self, webView: self.webView)
        Menu.registerMethods(self, webView: self.webView)
        ProcessInfo.registerMethods(self, webView: self.webView)
        UserDefaults.registerMethods(self, webView: self.webView)
        Tray.registerMethods(self, webView: self.webView)
        Workspace.registerMethods(self, webView: self.webView)
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        CurrentUser.processMessage(message)
        ProcessInfo.processMessage(message)
        UserDefaults.processMessage(message)
        Workspace.processMessage(message)
    }
    
}