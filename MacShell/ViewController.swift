//
//  ViewController.swift
//  MacShell
//
//  Created by Florian Hämmerle on 12/29/14.
//  Copyright (c) 2014 Florian Hämmerle. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)
        self.webView.autoresizingMask = NSAutoresizingMaskOptions.ViewHeightSizable | NSAutoresizingMaskOptions.ViewWidthSizable
        self.view.addConstraint(NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        
        
        registerAPIs(webView)
        
        self.webView.configuration.preferences.enableDevExtras()
        
        self.webView.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().resourcePath! + "/index.html")!))

        
        // application menu
        NSApplication.sharedApplication().mainMenu?.addItem(NSMenuItem())
        NSApplication.sharedApplication().mainMenu?.itemAtIndex(0)?.submenu = NSMenu()
        NSApplication.sharedApplication().mainMenu?.itemAtIndex(0)?.submenu?.addItem(NSMenuItem(title: "About MacShell", action: "aboutWindow", keyEquivalent: ""))
        NSApplication.sharedApplication().mainMenu?.itemAtIndex(0)?.submenu?.addItem(NSMenuItem.separatorItem())
        NSApplication.sharedApplication().mainMenu?.itemAtIndex(0)?.submenu?.addItem(NSMenuItem(title: "Preferences", action: "preferencesWindow", keyEquivalent: ""))
        
        var fileMenu = NSMenu(title: "File_2")
        var fileNewItem = NSMenuItem(title: "New", action: "fileMenu_New", keyEquivalent: "g")
        fileNewItem.keyEquivalentModifierMask = Int(NSEventModifierFlags.ControlKeyMask.rawValue)
        fileMenu.addItem(fileNewItem)
        
        fileMenu.addItem(NSMenuItem.separatorItem())
        
        var fileOpenItem = NSMenuItem(title: "Open", action: "fileMenu_Open", keyEquivalent: "o")
        fileOpenItem.keyEquivalentModifierMask = Int(NSEventModifierFlags.CommandKeyMask.rawValue)
        fileMenu.addItem(fileOpenItem)
        
        var fileMenuItem = NSMenuItem()
        fileMenuItem.submenu = fileMenu
        NSApplication.sharedApplication().mainMenu?.addItem(fileMenuItem)
    }
    
    func fileMenu_New() {
        NSLog("File / New");
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

