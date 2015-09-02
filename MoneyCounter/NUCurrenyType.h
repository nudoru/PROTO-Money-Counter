//
//  NUCurrenyType.h
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUCurrenyType : NSObject

typedef enum {
    CurrencyTypePenny,
	CurrencyTypeNickel,
	CurrencyTypeDime,
	CurrencyTypeQuarter,
	CurrencyTypeDollar,
	CurrencyTypeFive,
	CurrencyTypeTen,
	CurrencyTypeTwenty,
	CurrencyTypeFifty,
	CurrencyTypeHundred,
	CurrencyTypeNone,
} CurrencyType;

+(BOOL)isPaperType:(CurrencyType)inst;
+(BOOL)isCoinType:(CurrencyType)inst;

@end
