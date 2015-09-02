//
//  NUBaseInteraction.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 9/10/12.
//
//

#import <UIKit/UIKit.h>
#import "NUNotificationDefines.h"
#import "NUMessageTexts.h"
#import "NUCurrenyType.h"
#import "NUSoundEffectsList.h"
#import "NUGameAlertType.h"
#import "NUGameAlertMessage.h"

@interface NUBaseInteractionViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSTimeInterval lastCompletionTime;
@property (nonatomic) NSTimer *waitTimer;
@property (nonatomic) BOOL waitingForResume;

@property (nonatomic) NUGameAlertMessage *currentAlertMessage;
@property CGRect portraitFrame;

-(void) setViewFrame;

-(void) showGameAlert:(GameAlertType)type title:(NSString *)t message:(NSString *)m button:(NSString *)b stars:(int)stars sourceGameType:(GameType) srcGameType;
-(void) removeCurrentGameAlert;

- (void)handleGameAlertClose;

-(void) addDropShadowUIView:(UIImageView *)uiv;

-(NSString *) getSoundEffectForCurrencyType:(CurrencyType) currencyType;

-(void) startWaitTimer;
-(void) endWaitTimer:(NSTimer *)theTimer;
-(void) startCompletionTimer;
-(void) endCompletionTimer;

-(void) sendDebugMessage:(NSString *)text;
-(void) playSound:(NSString *)fName;

-(void) showQuitActionSheet;
-(void) quitGame;

-(void) destroy;
@end
