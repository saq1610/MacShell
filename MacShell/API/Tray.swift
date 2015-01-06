//
//  Tray.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Tray: NSObject, APIPackage {

}

extension Tray: APIPackage {
    func registerMethods(webView: WKWebView) {
        
    }
}

extension Tray: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        default:
            break
        }
    }
}