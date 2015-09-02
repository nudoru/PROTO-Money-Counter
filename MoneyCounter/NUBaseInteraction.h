//
//  NUBaseInteraction.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 9/10/12.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NUBaseInteraction : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate>

-(void)sendDebugMessage:(NSString *)text;

@end
