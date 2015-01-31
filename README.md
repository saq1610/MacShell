MacShell
========

MacShell is a basic application that uses Swift + JavaScript together. For web developers MacShell provides an easy way to develop their first applications for OS X. The window content is a web view. Features that aren't available to normal web applications have to be programmed using Swift, the user interface (except the window frame and application menu) are written with web technologies.

MacShell is currently in **alpha**. Features may change or be removed in future versions. Don't use MacShell in production yet!


### Notes

MacShell is written in Swift. It uses the new `WKWebView` that was shipped with Yosemite.


### How to Write an Application

Everything that can be done is done in JavaScript. Only features not possible with pure JavaScript have to be written in Swift (i.e. Menu, FileSystem, etc.). Basically, you write your own specific shell for every application. 
