//
//  NUCashTableView.h
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUCurrencyView.h"
#import "NUCurrencyMode.h"

#define kCashDrawerWidth 165
// height - width
#define kCashDrawerLeft 315

@interface NUCashTableView : UIView

@property (nonatomic) CurrencyMode currencyMode;

-(id)initWithFrame:(CGRect)frame andCurrencyMode:(CurrencyMode) mode;

-(void)addCurrency:(NUCurrencyView *)currency fromSource:(id)source;
-(void)removeAllCurrency;

@end
