//
//  NUMoneyUtilities.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "NUCurrencyView.h"
#import "NUCurrenyType.h"

@interface NUMoneyUtilities : NSObject

+(BOOL)isAmount:(float)amount perfectMatchToViewsInArrayAmount:(NSArray *)currencyViewsArry;
+(NSDictionary *)getDictionaryFromCurrencyViewsInArray:(NSArray *)currencyViewArry;
+(NSDictionary *)calculateBestSolutionForAmount:(float) amount;
+(int)getNumberOfItemsForAmount:(float)amount withDenomination:(float)denomination;
+(NSDictionary *)getDictionaryWithCurrencyTwenties:(int)twenties tens:(int)tens fives:(int)fives ones:(int)ones quarters:(int)quarters dimes:(int)dimes nickels:(int)nickels pennies:(int) pennies;


@end
