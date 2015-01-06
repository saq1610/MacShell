//
//  Menu.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class Menu: NSObject {
    /*
        template: [entries]
        entries: entry+
        entry: { label: string, submenu: entry?, accelerator: string }
    */
    func buildMenuFromTemplate(template: Array<AnyObject>) {
        println("build menu from template: \(template.description)")
        let label: AnyObject? = (template[0] as NSDictionary).valueForKey("label")
        println("First \(label)")
    }
}

extension Menu: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "buildMenuFromTemplate")
    }
}

extension Menu: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "buildMenuFromTemplate":
            buildMenuFromTemplate(message.body as Array<AnyObject>)
            
        default:
            break
        }
    }
}