//
//  GrowlSampleDisplay.h
//  Growl Display Plugins
//
//  Copyright 2006-2009 The Growl Project. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GrowlDisplayPlugin.h>
#import "InterceptorPrefs.h"
#import "JSON.h"


#define kInterceptorNotification @"InterceptorGrowlNotification"

@class GrowlApplicationNotification;

@interface InterceptorDisplay : GrowlDisplayPlugin {
    NSString *currentDisplayName;
    NSArray *knownSources;
    InterceptorPrefs *prefs;
    
    SBJsonWriter *writer;
    
}

@property (retain)SBJsonWriter *writer;
@property (retain)InterceptorPrefs *prefs;
@property (retain)NSString *currentDisplayName;
- (void) configureBridge:(GrowlNotificationDisplayBridge *)theBridge;

@end
