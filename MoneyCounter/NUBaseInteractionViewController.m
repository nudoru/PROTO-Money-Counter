//
//  NUBaseInteraction.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 9/10/12.
//
//

#import "NUBaseInteractionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NUBaseInteractionViewController

@synthesize startTime;
@synthesize lastCompletionTime;
// pause between currency adds
@synthesize waitTimer;
@synthesize waitingForResume;

@synthesize currentAlertMessage=currentAlertMessage_;

@synthesize portraitFrame=portraitFrame_;

-(id) init {
	self = [super init];
	if(self) {
		//
	}
	return self;
}

-(BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)setViewFrame {
	portraitFrame_ = CGRectMake(0, 0, 480, 320);
}

//---------------------------------------------------------------------------------------------------------
//
// ALERTS
//
//---------------------------------------------------------------------------------------------------------

-(void) showGameAlert:(GameAlertType)type title:(NSString *)t message:(NSString *)m button:(NSString *)b stars:(int)stars sourceGameType:(GameType) srcGameType {
	[self removeCurrentGameAlert];
	
	//GameType tmpType = model_.currentGameType;
	//if([model_ isCurrentMatchAScenarioGame]) tmpType = GameParentChallenge;
	
	currentAlertMessage_ = [[NUGameAlertMessage alloc] initWithType:type fromGameType:srcGameType title:t message:m button:b stars:stars];
	[[currentAlertMessage_ view] setFrame:portraitFrame_];
	[[self view] addSubview:[currentAlertMessage_ view]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleGameAlertClose) name:kNotificiationDismissGameAlert object:nil];
}

-(void) removeCurrentGameAlert {
	if(currentAlertMessage_) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificiationDismissGameAlert object:nil];
		[[currentAlertMessage_ view] removeFromSuperview];
		currentAlertMessage_ = nil;
	}
}


- (void)handleGameAlertClose {
	NSLog(@"handleGameAlertClose in base - SHOULD OVERRIDE");
	/*GameAlertType cType = [currentAlertMessage_ alertType];
	[self removeCurrentGameAlert];
	
	if(cType == GameAlertFail) {
		//NSLog(@"from too high");
		[self resetAndIncrementTries:YES];
	} else if(cType == GameAlertSuccess) {
		//NSLog(@"from great job");
		if([model_ isCurrentMatchAScenarioGame]) [self quitGame];
		else [self startNewMatchGame];
	} else {
		NSLog(@"closeCurrentGameAlert - Don't know this alert");
	}*/
}

//---------------------------------------------------------------------------------------------------------
//
// UTILITY
//
//---------------------------------------------------------------------------------------------------------

-(void)addDropShadowUIView:(UIImageView *)uiv {
	uiv.layer.shadowColor = [UIColor blackColor].CGColor;
	uiv.layer.shadowOffset = CGSizeMake(3, 3);
	uiv.layer.shadowOpacity = .9;
	uiv.layer.shadowRadius = 7.0;
}

-(NSString *) getSoundEffectForCurrencyType:(CurrencyType) currencyType {
	switch (currencyType) {
		case CurrencyTypePenny:
			return kSoundEffectAnnouncePenny;
			break;
		case CurrencyTypeNickel:
			return kSoundEffectAnnounceNickel;
			break;
		case CurrencyTypeDime:
			return kSoundEffectAnnounceDime;
			break;
		case CurrencyTypeQuarter:
			return kSoundEffectAnnounceQuarter;
			break;
		case CurrencyTypeDollar:
			return kSoundEffectAnnounceOne;
			break;
		case CurrencyTypeFive:
			return kSoundEffectAnnounceFive;
			break;
		case CurrencyTypeTen:
			return kSoundEffectAnnounceTen;
			break;
		case CurrencyTypeTwenty:
			return kSoundEffectAnnounceTwenty;
			break;
		default:
			return nil;
	}
}

//---------------------------------------------------------------------------------------------------------
//
// TIMER
//
//---------------------------------------------------------------------------------------------------------

// wait timer creates a delay between currency adds
-(void)startWaitTimer {
	if(waitTimer) [waitTimer invalidate];
	waitingForResume = YES;
	waitTimer = [NSTimer timerWithTimeInterval:.5 target:self selector:@selector(endWaitTimer:) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:waitTimer forMode:NSDefaultRunLoopMode];
}

-(void)endWaitTimer:(NSTimer *)theTimer {
	[waitTimer invalidate];
	waitingForResume = NO;
}

-(void)startCompletionTimer {
	startTime = [NSDate date];
	//NSLog(@"Start completion timer");
}

-(void)endCompletionTimer {
	lastCompletionTime = fabs([startTime timeIntervalSinceNow]);
	//NSLog(@"End completion time %f", lastCompletionTime);
}

//---------------------------------------------------------------------------------------------------------
//
// SOUND AND DEBUG
//
//---------------------------------------------------------------------------------------------------------

-(void)sendDebugMessage:(NSString *)text {
	NSDictionary *message = @{@"message": text};
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowDebugMessage object:nil userInfo:message];
}

-(void)playSound:(NSString *)fName {
	NSDictionary *message = @{@"soundfile": fName};
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPlaySound object:nil userInfo:message];
}

//---------------------------------------------------------------------------------------------------------
//
// UNLOAD/QUIT
//
//---------------------------------------------------------------------------------------------------------

-(void)showQuitActionSheet {
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle:kMessageGameQuit delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) [self quitGame];
}

-(void)quitGame {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEndCurrentGame object:self];
}

-(void) destroy {
	[self endWaitTimer:nil];
	startTime = nil;
	currentAlertMessage_ = nil;
}

@end
