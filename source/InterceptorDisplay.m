//
//  GrowlSampleDisplay.h
//  Growl Display Plugins
//
//  Copyright 2006-2009 The Growl Project. All rights reserved.
//

#import "InterceptorDisplay.h"
#import "GrowlApplicationNotification.h"
#import <GrowlDefinesInternal.h>
#import <GrowlDefines.h>
#import "GrowlPluginController.h"

@implementation InterceptorDisplay
@synthesize currentDisplayName,prefs,writer;



- (id) init {
	if ((self = [super init])) {
		windowControllerClass = nil;
        
        self.writer = [SBJsonWriter new];
        
        
        
	}
	return self;
}

- (void) dealloc {
    self.writer = nil;
    self.prefs = nil;
    self.currentDisplayName = nil;
	[preferencePane release];
	[super dealloc];
}

- (NSPreferencePane *) preferencePane {
	if (!preferencePane)
        
		preferencePane = [[InterceptorPrefs alloc] initWithBundle:[NSBundle bundleForClass:[InterceptorPrefs class]]];
    self.prefs = (InterceptorPrefs*)preferencePane;
	return preferencePane;
}







#pragma mark -
#pragma mark GrowlPositionController Methods
#pragma mark -

- (BOOL)requiresPositioning {
	return NO;
}

#pragma mark -
#pragma mark GAB
#pragma	mark -

- (void) configureBridge:(GrowlNotificationDisplayBridge *)theBridge {
    
    
    NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSLibraryDirectory,NSUserDomainMask, YES)];
    NSString *prefPath = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Preferences/com.Growl.GrowlHelperApp.plist"];
    NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefPath];
    
    self.currentDisplayName =  [prefs objectForKey:@"com.010dev.interceptor.defaultStyle"];
    if (self.currentDisplayName == nil) {
        self.currentDisplayName = @"Smoke"; 
    }
    
    //    NSLog(@"willDisplayUsingStyle: %@ \nself: %@",self.currentDisplayName, self);
    
    
    
    
	NSString *displayName = self.currentDisplayName;
	GrowlDisplayPlugin *displayPlugin = (GrowlDisplayPlugin *)[[GrowlPluginController sharedController] displayPluginInstanceWithName:displayName author:nil version:nil type:nil];
    
	GrowlApplicationNotification *notification = [theBridge notification] ;
	[displayPlugin displayNotification:notification];
    
    
    
    NSString *title = [notification title];
	NSString *text  = [notification notificationDescription];    
    NSString *src = [notification applicationName];
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:src forKey:@"src"];
    [dict setObject:title forKey:@"title"];
    [dict setObject:text forKey:@"text"];
    
    
    NSLog(@"%@", dict);
    
    
    [[NSDistributedNotificationCenter defaultCenter]postNotificationName:kInterceptorNotification object:[writer stringWithObject:dict] userInfo:nil deliverImmediately:YES];
    [dict release];
    
}

@end
