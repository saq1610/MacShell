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
    func registerMethods(webView: WKWebView)
}

func registerAPIs(webView: WKWebView) {
    Application().registerMethods(webView)
    CurrentUser().registerMethods(webView)
    ProcessInfo().registerMethods(webView)
    Window().registerMethods(webView)
    Workspace().registerMethods(webView)
}