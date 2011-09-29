//
//  ReemotePrefs.h
//  Sample
//
//  Created by ka010 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PreferencePanes/PreferencePanes.h>

#define SamplePrefDomain			@"com.Growl.Sample"

#define Sample_NOTIFICATION_STYLE   @"Smoke"


@interface InterceptorPrefs : NSPreferencePane<NSComboBoxDataSource, NSComboBoxDelegate> {
@private
    NSArray *notificationStyles;
    NSString *currentStyle;
    
    IBOutlet NSComboBox *comboBox;
}


@property(retain)NSString *currentStyle;
@property (retain) NSArray *notificationStyles;

- (NSString *) mainNibName ;
@end
