//
//  NUMoneyUtilities.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/6/12.
//
//

#import "NUMoneyUtilities.h"

@implementation NUMoneyUtilities

+(BOOL)isAmount:(float)amount perfectMatchToViewsInArrayAmount:(NSArray *)currencyViewsArry{
	NSDictionary *perfect = [NUMoneyUtilities calculateBestSolutionForAmount:amount];
	NSDictionary *onTable = [NUMoneyUtilities getDictionaryFromCurrencyViewsInArray:currencyViewsArry];
	
	if(![perfect[@"twenties"] isEqualToNumber:onTable[@"twenties"]]) return NO;
	if(![perfect[@"tens"] isEqualToNumber:onTable[@"tens"]]) return NO;
	if(![perfect[@"fives"] isEqualToNumber:onTable[@"fives"]]) return NO;
	if(![perfect[@"ones"] isEqualToNumber:onTable[@"ones"]]) return NO;
	if(![perfect[@"quarters"] isEqualToNumber:onTable[@"quarters"]]) return NO;
	if(![perfect[@"dimes"] isEqualToNumber:onTable[@"dimes"]]) return NO;
	if(![perfect[@"nickels"] isEqualToNumber:onTable[@"nickels"]]) return NO;
	if(![perfect[@"pennies"] isEqualToNumber:onTable[@"pennies"]]) return NO;
	
	return YES;
}

+(NSDictionary *)getDictionaryFromCurrencyViewsInArray:(NSArray *)currencyViewArry {
	int numTwenties=0;
	int numTens=0;
	int numFives=0;
	int numOnes=0;
	int numQuarters=0;
	int numDimes=0;
	int numNickels=0;
	int numPennies=0;
	
	for(NUCurrencyView *view in currencyViewArry) {
		if(view.currencyType == CurrencyTypeTwenty) numTwenties++;
		else if(view.currencyType == CurrencyTypeTen) numTens++;
		else if(view.currencyType == CurrencyTypeFive) numFives++;
		else if(view.currencyType == CurrencyTypeDollar) numOnes++;
		else if(view.currencyType == CurrencyTypeQuarter) numQuarters++;
		else if(view.currencyType == CurrencyTypeDime) numDimes++;
		else if(view.currencyType == CurrencyTypeNickel) numNickels++;
		else if(view.currencyType == CurrencyTypePenny) numPennies++;
	}
	
	return [self getDictionaryWithCurrencyTwenties:numTwenties tens:numTens fives:numFives ones:numOnes quarters:numQuarters dimes:numDimes nickels:numNickels pennies:numPennies];
}

// TODO this feels like too much of a hack
// refactor
+(NSDictionary *)calculateBestSolutionForAmount:(float) amount{
	int numTwenties=0;
	int numTens=0;
	int numFives=0;
	int numOnes=0;
	int numQuarters=0;
	int numDimes=0;
	int numNickels=0;
	int numPennies=0;
	float workingAmount = amount;
	numTwenties = [self getNumberOfItemsForAmount:workingAmount withDenomination:20];
	workingAmount -= (float) numTwenties * 20;
	numTens = [self getNumberOfItemsForAmount:workingAmount withDenomination:10];
	workingAmount -= (float) numTens * 10;
	numFives = [self getNumberOfItemsForAmount:workingAmount withDenomination:5];
	workingAmount -= (float) numFives * 5;
	numOnes = [self getNumberOfItemsForAmount:workingAmount withDenomination:1];
	workingAmount -= (float) numOnes * 1;
	workingAmount = roundf(workingAmount*100);
	numQuarters = [self getNumberOfItemsForAmount:workingAmount withDenomination:25];
	workingAmount -= (float) numQuarters * 25;
	numDimes = [self getNumberOfItemsForAmount:workingAmount withDenomination:10];
	workingAmount -= (float) numDimes * 10;
	numNickels = [self getNumberOfItemsForAmount:workingAmount withDenomination:5];
	workingAmount -= (float) numNickels * 5;
	numPennies = roundf(workingAmount);
	
	return [self getDictionaryWithCurrencyTwenties:numTwenties tens:numTens fives:numFives ones:numOnes quarters:numQuarters dimes:numDimes nickels:numNickels pennies:numPennies];
	
}

+(int)getNumberOfItemsForAmount:(float)amount withDenomination:(float)denomination {
	if(denomination > (float) amount) return 0;
	if(denomination == (float) amount) return 1;
	float remainder = fmod(amount,denomination);
	float left = amount - remainder;
	return (int) left / denomination;
}

+(NSDictionary *)getDictionaryWithCurrencyTwenties:(int)twenties tens:(int)tens fives:(int)fives ones:(int)ones quarters:(int)quarters dimes:(int)dimes nickels:(int)nickels pennies:(int) pennies {
	return @{@"twenties": [NSNumber numberWithDouble:twenties],
	@"tens": [NSNumber numberWithDouble:tens],
	@"fives": [NSNumber numberWithDouble:fives],
	@"ones": [NSNumber numberWithDouble:ones],
	@"quarters": [NSNumber numberWithDouble:quarters],
	@"dimes": [NSNumber numberWithDouble:dimes],
	@"nickels": [NSNumber numberWithDouble:nickels],
	@"pennies": [NSNumber numberWithDouble:pennies]};
	
}

@end
