//
//  NUGameViewController.h
//  MoneyCounter
//
//  Created by Matt Perkins on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUTitleScreenViewController.h"
#import "NUGameTypeSelectViewController.h"
#import "NUDifficultySelectViewController.h"
#import "NUCountingViewController.h"
#import "NUMoneyIDViewController.h"
#import "NUGameModel.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "OLGhostAlertView.h"
#import "NUNotificationDefines.h"
#import "Social/Social.h"


@interface NUGameViewController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic) NSUserDefaults *userDefaults;

@property (nonatomic) NUGameModel *gameModel;

@property (nonatomic) NUTitleScreenViewController *titleView;
@property (nonatomic) NUGameTypeSelectViewController *gameTypeView;
@property (nonatomic) NUDifficultySelectViewController *difficultyView;
@property (nonatomic) NUCountingViewController *countingView;
@property (nonatomic) NUMoneyIDViewController *moneyIDView;
@property (strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) id currentView;
@property (nonatomic) OLGhostAlertView *ghostView;
@property (nonatomic) NSString *pendingGhostMessaage;
@property (nonatomic) UIActivityViewController *sharingView;

@property (nonatomic) NSDictionary *selectedScenario;
@property (nonatomic) GameType selectedGameType;
@property (nonatomic) CurrencyMode selectedCurrencyMode;
@property (nonatomic) DifficultyLevel selectedDifficultyLevel;

-(void) applicationWillResignActive:(NSNotification *)notification;
-(void) showDebugMessage:(NSNotification*) notification;
-(void) postMessageToFaceBook:(NSNotification*)fbmessage;
-(void) playSoundFile:(NSNotification*)sndfile;

-(void)refeshDefaults;
-(void)checkDefaults;
-(void)continueViewDidLoad;
-(void)setupNotifications;

-(void)showGhostViewWithTitle:(NSString *)title;

-(void)showTitleScreen;

-(void) handleGameTypeSelection;
-(void) handleDifficultySelection;

-(void) startGamePlay;

-(void)showDifficultyMenu;
-(void)selectEasyGame;
-(void)selectMediumGame;
-(void)selectHardGame;

-(void)popCurrentSubMenuOff;

-(void)showScenarioCountingInteration:(NSDictionary *)details;

-(void) selectMoneyIDGame;
-(void) beginMoneyIDGame;

-(void)disposeOfCountingView;
-(void)selectFreePlayCountingInteraction;
-(void)beginFreePlayCountingInteraction;
-(void)beginCountingInteraction;
-(void)showCountingInteractionWithModel:(NUCountingGameModel *)model;
-(void)endCurrentGameInteraction;


@end
