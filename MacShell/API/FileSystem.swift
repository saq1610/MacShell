//
//  FileSystem.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/2/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

class FileSystem: NSObject, APIPackage {
    func registerMethods(handler: WKScriptMessageHandler, webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(handler, name: "doesFileExist")
    }
    
    func processMessage(message: WKScriptMessage) {
        switch (message.name) {
            case "doesFileExist":
                var path: String? = message.body as? String
                if (path != nil) {
                    message.webView?.evaluateJavaScript("console.log('\(doesFileExist(path!))')", completionHandler: nil)
                }
                break
            
        default:
            break
        }
    }
    
    func doesFileExist(path: String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
}