//
//  NUViewController.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUCountingViewController.h"
#import "NUDifficultyLevel.h"
#import "NUGameType.h"
#import "NUCurrencyView.h"
#import "NUCurrencyMode.h"
#import "NUGameAlertMessage.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface NUCountingViewController ()
	
@end

@implementation NUCountingViewController

@synthesize model=model_;

// bg views
@synthesize backgroundNIB=backgroundNIB_;
@synthesize countingUINIB=countingUINIB_;
@synthesize cashDrawerNIB=cashDrawerNIB_;
@synthesize backgroundView=backgroundView_;
@synthesize countingUIView=countingUIView_;
@synthesize cashDrawerView=cashDrawerView_;

// cash drawer items 
@synthesize cdOneDollarImage=cdOneDollarImage_;
@synthesize cdFiveDollarImage=cdFiveDollarImage_;
@synthesize cdTenDollarImage=cdTenDollarImage_;
@synthesize cdTwentyDollarImage=cdTwentyDollarImage_;
@synthesize cdPennyImage=cdPennyImage_;
@synthesize cdNickelImage=cdNickelImage_;
@synthesize cdDimeImage=cdDimeImage_;
@synthesize cdQuarterImage=cdQuarterImage_;

// interaction area
@synthesize table=table_;

@synthesize clearButton=clearButton_;
@synthesize amountLabel=amountLabel_;
@synthesize scenarioLabel=scenarioLabel_;

// int
@synthesize activeCurrencyType=activeCurrencyType_;



//---------------------------------------------------------------------------------------------------------
//
// INIT
//
//---------------------------------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// designated init
-(id) initWithModel:(NUCountingGameModel *)gmodel {
	self = [super init];
	if(self) {
		model_ = gmodel;
		
		[super setViewFrame];
	}
	
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	activeCurrencyType_ = CurrencyTypeNone;

	[self createUI];
	
	[super setWaitingForResume:NO];

	[self startNewMatchGame];
}

//---------------------------------------------------------------------------------------------------------
//
// SCENARIO
//
//---------------------------------------------------------------------------------------------------------

-(void) startNewMatchGame {
	[[NUGameModel sharedGameModel] incrementCurrentPlayerChallengesPresented];
	
	int currentTries = [model_ totalCurrentTries];
	int totalTries = [model_ totalTries];
	[model_ setTotalCurrentTries:0];
	[model_ setTotalTries:currentTries + totalTries];
	
	[model_ startNewMatchingGame];
	
	[self setScenarioText:[model_ getMatchingGameGoalText]];
	
	[model_ removeAllPlayedCurrencyViews];
	[table_ removeAllCurrency];
	[self setAmountText:[NSString stringWithFormat:@""]];
	
	if(model_.currentGameType != GameFree) [super playSound:@"sophie-matchamount"];
	
	[super startCompletionTimer];
	
	[clearButton_ setEnabled:NO];
}

-(void) setAmountTextForGameType {
	[self setAmountText:[model_ getCurrenctPlayedAmountText]];
}

-(void) determineGameMatch {
	[self setAmountTextForGameType];

	if(model_.currentGameType != GameFree) {
		double value = roundf ([model_ getValueOfCurrencyPlayed] * 100) / 100.0;
		double target = roundf ([model_ currentTargetAmount] * 100) / 100.0;
		
		if(value > target) {
			[self handleAmountTooHigh];
			return;
		} else if(value == target) {
			[self handleCorrectMatch];
			return;
		}
	}
	
	[super playSound:[super getSoundEffectForCurrencyType:activeCurrencyType_]];
	[clearButton_ setEnabled:YES];
}

-(int) getStarsAwarded {
	int starsAwarded = 0;
	
	if([model_ isPerfectCurrencyItemMatch]) starsAwarded++;
	if([model_ isPerfectTimeMatchForCurrentDifficulty:[super lastCompletionTime]]) starsAwarded++;
	if([model_ totalCurrentTries] == 0) starsAwarded++;
	
	return starsAwarded;
}

-(void) handleCorrectMatch {
	[super endCompletionTimer];
	
	[[NUGameModel sharedGameModel] incrementCurrentPlayerCorrectMatches];
	[[NUGameModel sharedGameModel] addGameTimeToCurrentPlayer:[super lastCompletionTime]];
	
	BOOL wasPerfect = NO;
	int starsAwarded = [self getStarsAwarded];
	
	[[NUGameModel sharedGameModel] addStarsToCurrentPlayer:starsAwarded];
	
	if(starsAwarded == 3) {
		[[NUGameModel sharedGameModel] incrementCurrentPlayerPerfectMatches];
		wasPerfect = YES;
	}
	
	[super playSound:kSoundEffectCountingGameMatch];
	NSString *title = [model_ totalCurrentTries] == 0 ? @"Perfect! Great job!" : @"Great job!";
	NSString *message = wasPerfect ? kMessageCountingPerfectMatch : kMessageCountingMatch;
	NSString *button = @"Try another";
	
	if([model_ isCurrentMatchAScenarioGame]) button = @"Done";
	
	[super showGameAlert:GameAlertSuccess title:title message:message button:button stars:starsAwarded  sourceGameType:model_.currentGameType];
}

-(void) handleAmountTooHigh {	
	[super playSound:kSoundEffectCountingGameTooHigh];
	
	[super showGameAlert:GameAlertFail title:@"Oh no ..." message:kMessageCountingTooHigh button:@"Try again" stars:0 sourceGameType:model_.currentGameType];
}

-(void) resetAndIncrementTries:(BOOL)increment {
	if(increment) {
		int tries = [model_ totalCurrentTries];
		[model_ setTotalCurrentTries:++tries];
	}
	
	[model_ removeAllPlayedCurrencyViews];
	[table_ removeAllCurrency];
	
	[self setAmountText:[NSString stringWithFormat:@""]];
	
	// don't say this message in a free play game
	if([model_ currentGameType] != GameFree) [super playSound:kSoundEffectCountingGameStart];
	
	[self startWaitTimer];
	
	[clearButton_ setEnabled:NO];
}

//---------------------------------------------------------------------------------------------------------
//
// RENDER
//
//---------------------------------------------------------------------------------------------------------


-(void)createUI {
	backgroundNIB_ = [UINib nibWithNibName:[self getBackgroundNIBName] bundle:[NSBundle mainBundle]];
	[backgroundNIB_ instantiateWithOwner:self options:nil];
	[backgroundView_ setFrame:super.portraitFrame];

	countingUINIB_ = [UINib nibWithNibName:@"NUCountingUI" bundle:[NSBundle mainBundle]];
	[countingUINIB_ instantiateWithOwner:self options:nil];
	[countingUIView_ setFrame:super.portraitFrame];
	
	// move it over
	CGRect cDrawerFrame = super.portraitFrame;
	cDrawerFrame.origin.x = super.portraitFrame.size.width - kCashDrawerWidth;
	cDrawerFrame.size.width = kCashDrawerWidth;
	
	cashDrawerNIB_ = [UINib nibWithNibName:[self getCashDrawerNIBName] bundle:[NSBundle mainBundle]];
	[cashDrawerNIB_ instantiateWithOwner:self options:nil];
	[cashDrawerView_ setFrame:cDrawerFrame];

	[[self view] addSubview:backgroundView_];
	[[self view] addSubview:countingUIView_];
	[[self view] addSubview:cashDrawerView_];
	
	[self addDropShadowToCurrencyInDrawer];
	
	table_ = [[NUCashTableView alloc]initWithFrame:CGRectZero andCurrencyMode:model_.currentCurrencyMode];
	[[self view] addSubview:table_];
}

-(NSString *)getBackgroundNIBName {
	if(model_.currentGameType == GameFree) return @"NUBGRug";

	if([model_ isCurrentMatchAScenarioGame]) return @"NUBGTileCarpet";
	
	switch (model_.currentDifficulty) {
		case DifficultyEasy:
		case DifficultyMedium:
			return @"NUBGRug";
			break;
		default:
			return @"NUBGCounter";
			break;
	}
}

-(NSString *)getCashDrawerNIBName {
	if(model_.currentGameType == GameFree) return @"NUCashDrawerFree";
	
	switch (model_.currentDifficulty) {
		case DifficultyEasy:
			return @"NUCashDrawerEasyCoin";
			break;
		case DifficultyMedium:
			return @"NUCashDrawerMediumPaper";
			break;
		default:
			return @"NUCashDrawerHard";
			break;
	}
}

-(void)addDropShadowToCurrencyInDrawer {
	if(cdOneDollarImage_) [self addDropShadowUIView:cdOneDollarImage_];
	if(cdFiveDollarImage_) [self addDropShadowUIView:cdFiveDollarImage_];
	if(cdTenDollarImage_) [self addDropShadowUIView:cdTenDollarImage_];
	if(cdTwentyDollarImage_) [self addDropShadowUIView:cdTwentyDollarImage_];
	if(cdPennyImage_) [self addDropShadowUIView:cdPennyImage_];
	if(cdNickelImage_) [self addDropShadowUIView:cdNickelImage_];
	if(cdDimeImage_) [self addDropShadowUIView:cdDimeImage_];
	if(cdQuarterImage_) [self addDropShadowUIView:cdQuarterImage_];
}

//---------------------------------------------------------------------------------------------------------
//
// CASH DRAWER INTERACTION
//
//---------------------------------------------------------------------------------------------------------


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];

	if(activeCurrencyType_ != CurrencyTypeNone) [self onCurrencyTouchFinished];
	
	if([super waitingForResume]) return;
	
	if([touch view] == cdOneDollarImage_) activeCurrencyType_ = CurrencyTypeDollar;
	else if([touch view] == cdFiveDollarImage_) activeCurrencyType_ = CurrencyTypeFive;
	else if([touch view] == cdTenDollarImage_) activeCurrencyType_ = CurrencyTypeTen;
	else if([touch view] == cdTwentyDollarImage_) activeCurrencyType_ = CurrencyTypeTwenty;
	else if([touch view] == cdPennyImage_) activeCurrencyType_ = CurrencyTypePenny;
	else if([touch view] == cdNickelImage_) activeCurrencyType_ = CurrencyTypeNickel;
	else if([touch view] == cdDimeImage_) activeCurrencyType_ = CurrencyTypeDime;
	else if([touch view] == cdQuarterImage_) activeCurrencyType_ = CurrencyTypeQuarter;
	//else NSLog(@"%@", [touch view]); // test what i'm tapping
	
	if(activeCurrencyType_ != CurrencyTypeNone) {
		[self handleCashDrawerCurrencyTouchFrom:[touch view]];
	}
}

// user touched something - "Source" the currency on the right side in the cash drawer view
-(void)handleCashDrawerCurrencyTouchFrom:(UIView *)source {
	[self addCurrenyViewFromSource:source];
	[self startWaitTimer];
	[self determineGameMatch];
}

// source is needed to determine x,y values to begin animation
-(void)addCurrenyViewFromSource:(UIView *)source {
	if(activeCurrencyType_ == CurrencyTypeNone) return;
	
	NUCurrencyView *cview = [[NUCurrencyView alloc]initWithCurrencyType:activeCurrencyType_];
	
	[table_ addCurrency:cview fromSource:source];
	[model_ addCurrencyViewToPlayedArray:cview];
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self onCurrencyTouchFinished];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self onCurrencyTouchFinished];
}

-(void)onCurrencyTouchFinished {
	activeCurrencyType_ = CurrencyTypeNone;
}

//---------------------------------------------------------------------------------------------------------
//
// ALERTS
//
//---------------------------------------------------------------------------------------------------------


- (void)handleGameAlertClose {
	GameAlertType cType = [super.currentAlertMessage alertType];
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
	}
}

//---------------------------------------------------------------------------------------------------------
//
// STATUS BAR
//
//---------------------------------------------------------------------------------------------------------

//TODO rename to onClearTap
- (IBAction)clearTap:(id)sender {
	[self resetAndIncrementTries:NO];
}

- (IBAction)onStopTap:(id)sender {
	[super showQuitActionSheet];
}

-(void)setAmountText:(NSString *)text {
	[amountLabel_ setText:text];
}

-(void)setScenarioText:(NSString *)text {
	[scenarioLabel_ setText:text];
}

//---------------------------------------------------------------------------------------------------------
//
// UNLOADING
//
//---------------------------------------------------------------------------------------------------------

-(void)dealloc {
	[self destroy];
}

-(void) destroy {
	[super destroy];
	
	model_ = nil;
	
	table_ = nil;
	backgroundNIB_ = nil;
	backgroundView_ = nil;
	countingUINIB_ = nil;
	countingUIView_ = nil;
	cashDrawerNIB_ = nil;
	cashDrawerView_ = nil;
	amountLabel_ = nil;
	clearButton_ = nil;

	// just to make sure, tell all children to remove themselves
	[[[self view] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
