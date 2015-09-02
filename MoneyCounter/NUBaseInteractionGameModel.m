//
//  NUBaseInteractionGameModel.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/6/12.
//
//

#import "NUBaseInteractionGameModel.h"

@implementation NUBaseInteractionGameModel

@synthesize currentDifficulty=currentDifficulty_;
@synthesize currentGameType=currentGameType_;
@synthesize currentCurrencyMode=currentCurrencyMode_;

@synthesize currencyPlayed=currencyPlayed_;
@synthesize totalCurrentTries=totalCurrentTries_;
@synthesize totalTries=totalTries_;
@synthesize currentTargetAmount=currentTargetAmount_;
@synthesize lastRandomAmounts=lastRandomAmounts_;

-(void)initFreeCountGameSettings {
	currentGameType_ = GameFree;
	currentDifficulty_ = DifficultyHard;
	currentCurrencyMode_ = PaperAndCoin;
	
	currencyPlayed_ = [[NSMutableArray alloc] init];
	totalTries_= 0;
	totalCurrentTries_=0;
	
	lastRandomAmounts_ = [[NSMutableArray alloc] init];
}


//---------------------------------------------------------------------------------------------------------
//
// NEW AMOUNT
//
//---------------------------------------------------------------------------------------------------------

// get a new random amount that's not in the last 5
-(double) getNewAmount {
	double amount;
	NSNumber *amoutObj;
	NSMutableArray *hitList = [[NSMutableArray alloc] init];
	BOOL hit = false;
	
	do {
		amount = [self getNewRandomAmountBasedOnCurrentDifficulty];
		amoutObj = @(amount);
		hit = [lastRandomAmounts_ containsObject:amoutObj];
		if(hit) [hitList addObject:amoutObj];
	} while (hit);
	
	[self addAmountToLastRandomAmounts:amoutObj removeObjects:hitList];
	
	return amount;
}

// get random amount according to difficulty rules
-(double) getNewRandomAmountBasedOnCurrentDifficulty {
	if(currentDifficulty_ == DifficultyEasy) return [self getRandomNumberMultipleOf:5 lessThan:30] * .01;
	else if(currentDifficulty_ == DifficultyMedium) return [self getRandomNumberMultipleOf:5 lessThan:50] + .0;
	else if(currentDifficulty_ == DifficultyHard) return ((arc4random()%1000) * .01) + .01;
	return 1.00;
}

-(int) getRandomNumberMultipleOf:(int)multiple lessThan:(int)range {
	int r;
	do {
		r = arc4random()%range + 1;
	} while ((r%multiple) != 0 && r>0);
	return r;
}

-(BOOL) isAmountInLastRandomAmounts:(NSNumber *) amount {
	return [lastRandomAmounts_ containsObject:amount];
}

-(void) addAmountToLastRandomAmounts:(NSNumber *) amount removeObjects:(NSArray *) removeObjs {
	[lastRandomAmounts_ removeObjectsInArray:removeObjs];
	[lastRandomAmounts_ addObject:amount];
	
	if([lastRandomAmounts_ count] > 4) [lastRandomAmounts_ removeObjectAtIndex:0];
}

-(double) getValueOfCurrencyPlayed {
	double amount = 0.00;
	for (NUCurrencyView *cv in currencyPlayed_) {
		amount += [cv value];
	}
	return amount;
}

-(NSString *) getCurrenctPlayedAmountText {
	// default is for hard
	NSString *defaultText = [NSString stringWithFormat:@"$%0.2f", [self getValueOfCurrencyPlayed]];
	
	// this way (.0f) prevents rounding and shows cents
	if(currentDifficulty_ == DifficultyEasy) {
		double cents = [self getValueOfCurrencyPlayed] * 100;
		if(cents <= 1) defaultText = [NSString stringWithFormat:@"%.0f cent", cents];
			else defaultText = [NSString stringWithFormat:@"%.0f cents", cents];
	}
	if(currentDifficulty_ == DifficultyMedium) {
		int dollars = (int)[self getValueOfCurrencyPlayed];
		if(dollars <= 1) defaultText = [NSString stringWithFormat:@"$%d dollar", dollars];
			else defaultText = [NSString stringWithFormat:@"$%d dollars", dollars];
	}
	
	return defaultText;
}

//---------------------------------------------------------------------------------------------------------
//
// DESTROY
//
//---------------------------------------------------------------------------------------------------------

-(void) destroy {
	currencyPlayed_ = nil;
	lastRandomAmounts_ = nil;
}

@end
