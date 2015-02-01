//
//  Application.swift
//  MacShell
//
//  Created by Florian Hämmerle on 2/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Application: NSObject {
    func terminate() {
        return NSApp.terminate()
    }
}

extension Application: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "terminate")
    }
}

extension Application: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "terminate":
            terminate()
            
        default:
            break
        }
    }
}
