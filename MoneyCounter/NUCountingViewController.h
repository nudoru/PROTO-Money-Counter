//
//  NUViewController.h
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "NUBaseInteractionViewController.h"
#import "NUGameModel.h"
#import "NUCashTableView.h"
#import "NUCurrenyType.h"
#import "NUCountingGameModel.h"
#import "NUGameAlertType.h"
#import "NUNotificationDefines.h"
#import "NUMessageTexts.h"
#import "NUSoundEffectsList.h"

@interface NUCountingViewController : NUBaseInteractionViewController

@property (nonatomic) NUCountingGameModel *model;


@property (nonatomic) NUCashTableView *table;

@property (nonatomic) UINib *backgroundNIB;
@property (nonatomic) UINib *countingUINIB;
@property (nonatomic) UINib *cashDrawerNIB;
@property (nonatomic) IBOutlet UIView *backgroundView;
@property (nonatomic) IBOutlet UIView *countingUIView;
@property (nonatomic) IBOutlet UIView *cashDrawerView;

@property (nonatomic) IBOutlet UIImageView *cdOneDollarImage;
@property (nonatomic) IBOutlet UIImageView *cdFiveDollarImage;
@property (nonatomic) IBOutlet UIImageView *cdTenDollarImage;
@property (nonatomic) IBOutlet UIImageView *cdTwentyDollarImage;
@property (nonatomic) IBOutlet UIImageView *cdPennyImage;
@property (nonatomic) IBOutlet UIImageView *cdNickelImage;
@property (nonatomic) IBOutlet UIImageView *cdDimeImage;
@property (nonatomic) IBOutlet UIImageView *cdQuarterImage;

@property (nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (nonatomic) IBOutlet UILabel *amountLabel;
@property (nonatomic) IBOutlet UILabel *scenarioLabel;

@property (nonatomic) CurrencyType activeCurrencyType;

-(id) initWithModel:(NUCountingGameModel *)gmodel;

-(void) startNewMatchGame;
-(void) setAmountTextForGameType;
-(void) determineGameMatch;
-(int) getStarsAwarded;
-(void) handleCorrectMatch;
-(void) handleAmountTooHigh;
-(void) resetAndIncrementTries:(BOOL)increment;

-(void) createUI;

-(NSString *) getBackgroundNIBName;
-(NSString *) getCashDrawerNIBName ;
-(void) addDropShadowToCurrencyInDrawer;

-(void) handleCashDrawerCurrencyTouchFrom:(UIView *)source;
-(void) addCurrenyViewFromSource:(UIView *)source;
-(void) onCurrencyTouchFinished;

-(void) handleGameAlertClose ;

- (IBAction) clearTap:(id)sender;
- (IBAction) onStopTap:(id)sender;
-(void) setAmountText:(NSString *)text;
-(void) setScenarioText:(NSString *)text;

-(void) destroy;

@end
