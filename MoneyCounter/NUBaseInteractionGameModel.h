//
//  NUBaseInteractionGameModel.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "NUCurrenyType.h"
#import "NUCurrencyView.h"
#import "NUDifficultyLevel.h"
#import "NUGameType.h"
#import "NUCurrencyMode.h"
#import "NUCompletionTimeValues.h"

@interface NUBaseInteractionGameModel : NSObject

@property (nonatomic) DifficultyLevel currentDifficulty;
@property (nonatomic) GameType currentGameType;
@property (nonatomic) CurrencyMode currentCurrencyMode;

@property (nonatomic, copy) NSMutableArray *currencyPlayed;
@property (nonatomic) int totalCurrentTries;
@property (nonatomic) int totalTries;
@property (nonatomic) double currentTargetAmount;
@property (nonatomic, copy) NSMutableArray *lastRandomAmounts;

-(void)initFreeCountGameSettings;

-(double) getNewAmount;
-(double) getNewRandomAmountBasedOnCurrentDifficulty;
-(int) getRandomNumberMultipleOf:(int)multiple lessThan:(int)range;
-(BOOL) isAmountInLastRandomAmounts:(NSNumber *) amount;
-(void) addAmountToLastRandomAmounts:(NSNumber *) amount removeObjects:(NSArray *) removeObjs;

-(double) getValueOfCurrencyPlayed;
-(NSString *) getCurrenctPlayedAmountText;

-(void)destroy;

@end
