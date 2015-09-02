//
//  NUCurrencyView.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NUCurrencyView.h"
#import "NUCurrenyType.h"

#define DOLLAR_WIDTH 237
#define DOLLAR_HEIGHT 100
#define COIN_WIDTH 67
#define COIN_HEIGHT 67

@implementation NUCurrencyView

@synthesize currencyType=currencyType_;
@synthesize currencyImage=currencyImage_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// DESIGNATED INIT
-(id) initWithCurrencyType:(CurrencyType) type {
	self = [self initWithFrame:CGRectZero];
	if(self) {
		[self setCurrencyType:type];
		[self setFrame:[self createRectFromType]];
		[self showImage];
		
	}
	return self;
}

-(void)showImage {
	UIImage *imageForAnim = [self renderImageForAntialiasing:[UIImage imageNamed:[self getCurrencyImageName]] withInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
	
	currencyImage_ = [[UIImageView alloc] initWithImage:imageForAnim];
	[currencyImage_ setContentMode:UIViewContentModeScaleToFill];
	
	[self addSubview:currencyImage_];
}

// from here http://markpospesel.wordpress.com/2012/03/30/efficient-edge-antialiasing/
- (UIImage *)renderImageForAntialiasing:(UIImage *)image withInsets:(UIEdgeInsets)insets
{
    CGSize imageSizeWithBorder = CGSizeMake([image size].width + insets.left + insets.right, [image size].height + insets.top + insets.bottom);
	
    // Create a new context of the desired size to render the image
    UIGraphicsBeginImageContextWithOptions(imageSizeWithBorder, NO, 0);
	
    // The image starts off filled with clear pixels, so we don't need to explicitly fill them here
    [image drawInRect:(CGRect){{insets.left, insets.top}, [image size]}];
	
    // Fetch the image
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return renderedImage;
}

-(CGRect) createRectFromType {
	switch (currencyType_) {
		case CurrencyTypePenny:
		case CurrencyTypeNickel:
		case CurrencyTypeDime:
		case CurrencyTypeQuarter:
			return CGRectMake(0, 0, COIN_WIDTH, COIN_HEIGHT);
			break;
			
		default:
			return CGRectMake(0, 0, DOLLAR_WIDTH, DOLLAR_HEIGHT);
	}
}

-(float) value {
	switch (currencyType_) {
		case CurrencyTypePenny:
			return 0.01;
			break;
		case CurrencyTypeNickel:
			return 0.05;
			break;
		case CurrencyTypeDime:
			return 0.1;
			break;
		case CurrencyTypeQuarter:
			return 0.25;
			break;
		case CurrencyTypeDollar:
			return 1.0;
			break;
		case CurrencyTypeFive:
			return 5.0;
			break;
		case CurrencyTypeTen:
			return 10.0;
			break;
		case CurrencyTypeTwenty:
			return 20.0;
			break;
		default:
			return 0.0;
	}
}

-(NSString *) getCurrencyImageName {
	switch (currencyType_) {
		case CurrencyTypePenny:
			return @"penny.png";
			break;
		case CurrencyTypeNickel:
			return @"nickel.png";
			break;
		case CurrencyTypeDime:
			return @"dime.png";
			break;
		case CurrencyTypeQuarter:
			return @"quarter.png";
			break;
		case CurrencyTypeDollar:
			return @"one.png";
			break;
		case CurrencyTypeFive:
			return @"five.png";
			break;
		case CurrencyTypeTen:
			return @"ten.png";
			break;
		case CurrencyTypeTwenty:
			return @"twenty.png";
			break;
		default:
			return nil;
	}
}

-(void)dealloc {
	//NSLog(@"dealloc currency view");
	currencyImage_ = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
