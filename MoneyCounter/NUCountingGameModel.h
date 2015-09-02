//
//  NUCountingModel.h
//  MoneyCounter
//
//  Created by Matt Perkins on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NUBaseInteractionGameModel.h"
#import "NUMoneyUtilities.h"
#import "NUCurrenyType.h"
#import "NUCurrencyView.h"
#import "NUDifficultyLevel.h"
#import "NUGameType.h"
#import "NUCurrencyMode.h"
#import "NUCompletionTimeValues.h"

#define kScenarioDetailsKey @"details"
#define kScenarioAmountKey @"amount"
#define kScenarioType @"type"

@interface NUCountingGameModel : NUBaseInteractionGameModel

@property (nonatomic) NSDictionary *scenario;

-(void) startNewMatchingGame;

-(BOOL) isCurrentMatchAScenarioGame;
-(NSString *) getMatchingGameGoalText;

-(void) addCurrencyViewToPlayedArray:(NUCurrencyView *)money;
-(void) removeAllPlayedCurrencyViews;

-(BOOL) isPerfectCurrencyItemMatch;
-(BOOL) isPerfectTimeMatchForCurrentDifficulty:(NSTimeInterval) time;

@end
