//
//  NUCurrenyType.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUCurrenyType.h"

@implementation NUCurrenyType

+(BOOL)isCoinType:(CurrencyType)inst {
	if(inst == CurrencyTypePenny ||
	   inst == CurrencyTypeNickel ||
	   inst == CurrencyTypeDime ||
	   inst == CurrencyTypeQuarter) return YES;
	return NO;
}

+(BOOL)isPaperType:(CurrencyType)inst {
	if(inst == CurrencyTypeDollar ||
	   inst == CurrencyTypeFive ||
	   inst == CurrencyTypeTen ||
	   inst == CurrencyTypeTwenty ||
	   inst == CurrencyTypeFifty ||
	   inst == CurrencyTypeHundred) return YES;
	return NO;
}

@end
