//
//  NUCurrencyMode.h
//  MoneyCounter
//
//  Created by Matt Perkins on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUCurrencyMode : NSObject

typedef enum {
	PaperOnly,
	CoinOnly,
	PaperAndCoin,
} CurrencyMode;

@end
