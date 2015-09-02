//
//  NUCountingModel.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUCountingGameModel.h"


@implementation NUCountingGameModel


@synthesize scenario=scenario_;

-(id)init {
	self = [super init];
	if(self) {
		// init w/ settings for a freecount game
		[super initFreeCountGameSettings];
	}
	return self;
}

-(void) startNewMatchingGame {
	if(scenario_) {
		super.currentTargetAmount = [scenario_[kScenarioAmountKey] doubleValue];
		NSLog(@"Scenario target amount: %f", super.currentTargetAmount);
	} else {
		super.currentTargetAmount = [super getNewAmount];
	}
	
}

//---------------------------------------------------------------------------------------------------------
//
// GAME INFORMATION
//
//---------------------------------------------------------------------------------------------------------

// Scenarios are from Parent's Challenge
-(BOOL)isCurrentMatchAScenarioGame {
	if(scenario_) return YES;
	return NO;
}

-(NSString *) getMatchingGameGoalText {
	if(scenario_ ) return scenario_[kScenarioDetailsKey];
	
	NSString *text = [NSString stringWithFormat:@"How do you make $%0.2f?", super.currentTargetAmount];
	
	if(super.currentGameType == GameFree) {
		text = @"Tap to add money.";
	} else {
		if(super.currentCurrencyMode == CoinOnly) text = [NSString stringWithFormat:@"How do you make %d cents?", (int)(super.currentTargetAmount * 100)];
		else if(super.currentCurrencyMode == PaperOnly) text = [NSString stringWithFormat:@"How do you make $%d dollars?", (int)super.currentTargetAmount];
	}
	return text;
}


//---------------------------------------------------------------------------------------------------------
//
// GAME PLAY
//
//---------------------------------------------------------------------------------------------------------

// TODO move this to super?
-(void) addCurrencyViewToPlayedArray:(NUCurrencyView *)money {
	[super.currencyPlayed addObject:money];
}

-(void) removeAllPlayedCurrencyViews {
	[super.currencyPlayed removeAllObjects];
}



//---------------------------------------------------------------------------------------------------------
//
// TESTING SUCCESS
//
//---------------------------------------------------------------------------------------------------------

-(BOOL) isPerfectCurrencyItemMatch {
	return [NUMoneyUtilities isAmount:super.currentTargetAmount perfectMatchToViewsInArrayAmount:super.currencyPlayed];
}

-(BOOL)isPerfectTimeMatchForCurrentDifficulty:(NSTimeInterval) time {
	NSLog(@"Compare time to: %f", time);
	if(super.currentDifficulty == DifficultyEasy && time < kCompleteTimeCountingLowAgeEasy) return YES;
	if(super.currentDifficulty == DifficultyMedium && time < kCompleteTimeCountingLowAgeMedium) return YES;
	if(super.currentDifficulty == DifficultyHard && time < kCompleteTimeCountingLowAgeHard) return YES;
	return NO;
}

//---------------------------------------------------------------------------------------------------------
//
// DESTROY
//
//---------------------------------------------------------------------------------------------------------

-(void)destroy {
	scenario_ = nil;
	[super destroy];
}

-(void) dealloc {
	[self destroy];
}

@end
