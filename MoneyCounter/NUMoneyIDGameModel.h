//
//  NUMoneyIDGameModel.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/2/12.
//
//

#import <Foundation/Foundation.h>

#import "NUCurrenyType.h"
#import "NUCurrencyView.h"
#import "NUDifficultyLevel.h"
#import "NUGameType.h"
#import "NUCurrencyMode.h"
#import "NUCompletionTimeValues.h"

#define kScenarioDetailsKey @"details"
#define kScenarioAmountKey @"amount"
#define kScenarioType @"type"

@interface NUMoneyIDGameModel : NSObject

@property (nonatomic) DifficultyLevel currentDifficulty;
@property (nonatomic) GameType currentGameType;
@property (nonatomic) CurrencyMode currentCurrencyMode;

@property (nonatomic, copy) NSMutableArray *lastFiveAmounts;
@property (nonatomic, copy) NSMutableArray *currencyOnTable;

@property (nonatomic) int totalCurrentTries;
@property (nonatomic) int totalTries;

@end
