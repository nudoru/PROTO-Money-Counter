//
//  NUCashTableView.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUCashTableView.h"
#import "NUCurrencyMode.h"
#import <QuartzCore/QuartzCore.h>

@implementation NUCashTableView

@synthesize currencyMode=currencyMode_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andCurrencyMode:(CurrencyMode) mode {
	self = [self initWithFrame:frame];
	if(self) {
		currencyMode_ = mode;
	}
	return self;
}

-(void)addCurrency:(NUCurrencyView *)currency fromSource:(id)source  {
	[self addSubview:currency];
	
	CGRect initedPosition = [currency frame];
	
	if(source) {
		
		UIImageView *sourceImage = source;
		
		CGRect sourcePosition = [sourceImage frame];
		[currency setFrame:CGRectMake(sourcePosition.origin.x + kCashDrawerLeft, sourcePosition.origin.y, sourcePosition.size.width, sourcePosition.size.height)];
		
		// copy scale of source, TOOD appears offset since it's scaled from the middle?
		//currency.currencyImage.transform = CGAffineTransformMakeScale(sourcePosition.size.width/initedPosition.size.width , sourcePosition.size.height/initedPosition.size.height);
		
	} else {
		// position it off the top for the initial drop in animation
		[currency setFrame:CGRectMake(100, -100, [currency frame].size.width, [currency frame].size.height)];	
	}
	
	// destination positions, paper at the top and coin at the bottom
	CGRect newPosition = [currency frame];
	newPosition.size.width = initedPosition.size.width;
	newPosition.size.height = initedPosition.size.height;
	
	// position based on currency mode
	if(currencyMode_ == CoinOnly) {
		newPosition.origin.x = 10 + arc4random()%185;
		newPosition.origin.y = 45 + arc4random()%165;
	} else if(currencyMode_ == PaperOnly) {
		newPosition.origin.x = 10 + arc4random()%90;
		newPosition.origin.y = 45 + arc4random()%100;
	} else {
		if([NUCurrenyType isPaperType:[currency currencyType]]) {
			newPosition.origin.x = 10 + arc4random()%100;
			newPosition.origin.y = 45 + arc4random()%50;
		} else {
			newPosition.origin.x = 50 + arc4random()%185;
			newPosition.origin.y = 180 + arc4random()%30;
		}
	}
		
	[UIView animateWithDuration:1 delay:0.0 
						options:UIViewAnimationCurveEaseOut 
					 animations:^{
						 [currency setFrame:newPosition];
						 // coins are rotated more than paper
						 int amount = [NUCurrenyType isPaperType:[currency currencyType]] ? 10 : 70;
						 // randomly flip the rotation +/- for a little more realism
						 float rot = (arc4random()%amount) * .01 * (arc4random()%2 == 1 ? -1 : 1);
						 currency.currencyImage.transform = CGAffineTransformMakeRotation(rot);
						 //currency.currencyImage.transform = CGAffineTransformMakeScale(1, 1);
					 } 
					 completion:nil];
}

-(void)removeAllCurrency {
	for(NUCurrencyView *currency in [self subviews]) {
		[UIView animateWithDuration:1 delay:(arc4random()%50) * .01
							options:UIViewAnimationCurveEaseIn 
						 animations:^{
							 [currency setFrame:CGRectMake(100, 500, [currency frame].size.width, [currency frame].size.height)];
						 } 
						 completion:^(BOOL completed){
							 [currency removeFromSuperview];
						 }];
	}
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void) dealloc {
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
