//
//  ReemotePrefs.m
//  Sample
//
//  Created by ka010 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InterceptorPrefs.h"
#import "GrowlPluginController.h"

@implementation InterceptorPrefs
@synthesize notificationStyles, currentStyle;

- (NSString *) mainNibName {
	return @"InterceptorPrefs";
}

- (void) mainViewDidLoad {
    [[comboBox cell]setStringValue:self.currentStyle];
}




#pragma mark -
#pragma mark NSComboBox datasource

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    return self.notificationStyles.count;
}


-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    return [[self.notificationStyles objectAtIndex:index]objectForKey:GrowlPluginInfoKeyName];
}





#pragma mark NSComboBox delegate

-(void)comboBoxSelectionDidChange:(NSNotification *)notification {
    NSComboBox *box = (NSComboBox *)[notification object];
   // self.display.currentDisplayName = [[self.notificationStyles objectAtIndex:[box indexOfSelectedItem]]objectForKey:GrowlPluginInfoKeyName];
    self.currentStyle = [[self.notificationStyles objectAtIndex:[box indexOfSelectedItem]]objectForKey:GrowlPluginInfoKeyName];

    NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSLibraryDirectory,NSUserDomainMask, YES)];
    NSString *prefPath = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Preferences/com.Growl.GrowlHelperApp.plist"];
    NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefPath];
    [prefs setObject:self.currentStyle forKey:@"com.010dev.interceptor.defaultStyle"];
    [prefs writeToFile:prefPath atomically:NO];
}




-(id)initWithBundle:(NSBundle *)bundle {
    self = [super initWithBundle:bundle];
    if (self) {
        
        self.notificationStyles = [[GrowlPluginController sharedController]displayPlugins];
        
        NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSLibraryDirectory,NSUserDomainMask, YES)];
        NSString *prefPath = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Preferences/com.Growl.GrowlHelperApp.plist"];
        NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefPath];

        self.currentStyle = [prefs objectForKey:@"com.010dev.interceptor.defaultStyle"];
        if (self.currentStyle == nil) {
            self.currentStyle = @"Smoke";
        }
    }
    
    return self;
}



- (void)dealloc
{
    
    [self.notificationStyles release];
    [super dealloc];
}

@end
