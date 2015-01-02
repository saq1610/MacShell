//
//  Dock.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Dock: NSObject, APIPackage {
    func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "setDockTileBadge")
    }
    
    func processMessage(message: WKScriptMessage) {
        switch (message.name) {
        case "setDockTileBadge":
            NSApplication.sharedApplication().dockTile.badgeLabel = ((message.body as NSDictionary).valueForKey("label") as String)
            break
        default:
            break
        }
    }
}