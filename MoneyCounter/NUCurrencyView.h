//
//  NUCurrencyView.h
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUCurrenyType.h"

@interface NUCurrencyView : UIView

@property (nonatomic) CurrencyType currencyType;
@property (nonatomic, strong) UIImageView *currencyImage;

-(id) initWithCurrencyType:(CurrencyType)type;

-(void)showImage;
-(CGRect) createRectFromType;
-(float) value;
-(NSString *) getCurrencyImageName;

@end
