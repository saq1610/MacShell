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
    func doesFileExist(path: String) -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    
    func isDirectory(path: String) -> Bool {
        var isDir = ObjCBool(false)
        NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &isDir)
        return isDir.boolValue
    }
    
    func moveItem(fromPath: String, toPath: String) -> Bool {
        return NSFileManager.defaultManager().moveItemAtPath(fromPath, toPath: toPath, error: nil)
    }
    
    func removeItem(path: String) -> Bool {
        return NSFileManager.defaultManager().removeItemAtPath(path, error: nil)
    }
}

extension FileSystem: APIPackage {
    func registerMethods(webView: WKWebView) {
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "doesFileExist")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "isDirectory")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "moveItem")
        webView.configuration.userContentController.addScriptMessageHandler(self, name: "removeItem")
    }
}

extension FileSystem: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "doesFileExist":
            var path: String? = message.body as? String
            if path != nil {
                message.webView?.evaluateJavaScript("console.log('\(doesFileExist(path!))')", completionHandler: nil)
            }
            break
            
        case "isDirectory":
            if let path = message.body as? String {
                message.webView?.evaluateJavaScript("console.log('\(isDirectory(path))')", completionHandler: nil)
            }
            break
            
        case "moveItem":
            let fromPath: String? = (message.body as NSDictionary).valueForKey("from") as? String
            let toPath: String? = (message.body as NSDictionary).valueForKey("to") as? String
            if fromPath != nil && toPath != nil {
                message.webView?.evaluateJavaScript("console.log('\(moveItem(fromPath!, toPath: toPath!))')", completionHandler: nil)
            }
            break
            
        case "removeItem":
            var path: String? = message.body as? String
            if path != nil {
                message.webView?.evaluateJavaScript("console.log('\(removeItem(path!))')", completionHandler: nil)
            }
            break
            
        default:
            break
        }
    }
}