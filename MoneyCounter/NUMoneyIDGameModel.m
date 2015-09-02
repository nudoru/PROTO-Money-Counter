//
//  NUMoneyIDGameModel.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/2/12.
//
//

#import "NUMoneyIDGameModel.h"

@implementation NUMoneyIDGameModel

// settings
@synthesize currentDifficulty=currentDifficulty_;
@synthesize currentGameType=currentGameType_;
@synthesize currentCurrencyMode=currentCurrencyMode_;
@synthesize currencyOnTable=currencyOnTable_;
@synthesize totalCurrentTries=totalCurrentTries_;
@synthesize totalTries=totalTries_;
@synthesize lastFiveAmounts=lastFiveAmounts_;

-(id)init {
	self = [super init];
	if(self) {
		// init w/ settings for a freecount game
		currentGameType_ = GameFree;
		currentDifficulty_ = DifficultyHard;
		currentCurrencyMode_ = PaperAndCoin;
		
		currencyOnTable_ = [[NSMutableArray alloc] init];
		totalTries_=0;
		totalCurrentTries_=0;
		
		lastFiveAmounts_ = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
