//
//  Dock.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Dock: NSObject {
    func setDockTileBadge(label: String) {
        NSApplication.sharedApplication().dockTile.badgeLabel = label
    }
}

extension Dock: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "setDockTileBadge")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "clearDockTileBadge")
    }
}

extension Dock: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "setDockTileBadge":
            setDockTileBadge((message.body as NSDictionary).valueForKey("label") as String)
            
        case "clearDockTileBadge":
            setDockTileBadge("")
            
        default:
            break
        }
    }
}