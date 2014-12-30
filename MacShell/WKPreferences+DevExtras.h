//
//  WKPreferences+DevExtras.h
//  MacShell
//
//  Created by Florian Hämmerle on 12/29/14.
//  Copyright (c) 2014 Florian Hämmerle. All rights reserved.
//

#ifndef MacShell_WKPreferences_DevExtras_h
#define MacShell_WKPreferences_DevExtras_h

@import WebKit;

@interface WKPreferences (DevExtras)

@property (nonatomic, setter=_setDeveloperExtrasEnabled:) BOOL _developerExtrasEnabled;

- (void) enableDevExtras;

@end

#endif
