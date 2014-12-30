//
//  WKPreferences+DevExtras.m
//  MacShell
//
//  Created by Florian Hämmerle on 12/29/14.
//  Copyright (c) 2014 Florian Hämmerle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKPreferences+DevExtras.h"

@implementation WKPreferences (DevExtras)

@dynamic _developerExtrasEnabled;

- (void) enableDevExtras {
    [self _setDeveloperExtrasEnabled:YES];
}

@end