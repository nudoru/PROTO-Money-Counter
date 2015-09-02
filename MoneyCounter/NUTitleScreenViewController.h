//
//  NUTitleScreenViewController.h
//  MoneyCounter
//
//  Created by Matt Perkins on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NUNotificationDefines.h"

@interface NUTitleScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;

- (IBAction)onJustCountTap:(id)sender;
- (IBAction)onPlayTap:(id)sender;

@end
