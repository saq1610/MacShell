//
//  APIPackage.swift
//  MacShell
//
//  Created by Florian Hämmerle on 1/1/15.
//  Copyright (c) 2015 Florian Hämmerle. All rights reserved.
//

import Foundation
import WebKit

protocol APIPackage {
    class func registerMethod(handler: WKScriptMessageHandler, webView: WKWebView)
    class func processMessage(message: WKScriptMessage)
}