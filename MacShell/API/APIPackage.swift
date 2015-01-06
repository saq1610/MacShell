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
    CurrentUser().registerMethods(webView)
    Dock().registerMethods(webView)
    FileSystem().registerMethods(webView)
    Menu().registerMethods(webView)
    ProcessInfo().registerMethods(webView)
    Tray().registerMethods(webView)
    UserDefaults().registerMethods(webView)
    Workspace().registerMethods(webView)
}