//
//  NUGameViewController.m
//  MoneyCounter
//
//  Created by Matt Perkins on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUGameViewController.h"
#import "NUGameType.h"
#import "NUDifficultyLevel.h"
#import "NUCurrencyMode.h"
#import "UINavigationController_Additions.h"

@interface NUGameViewController ()

@end

@implementation NUGameViewController

@synthesize userDefaults=userDefaults_;
@synthesize gameModel=gameModel_;

@synthesize titleView=titleView_;
@synthesize gameTypeView=gameTypeView_;
@synthesize difficultyView=difficultyView_;
@synthesize countingView=countingView_;
@synthesize moneyIDView=moneyIDView_;
@synthesize audioPlayer=audioPlayer_;

@synthesize currentView=currentView_;
@synthesize ghostView=ghostView_;
@synthesize pendingGhostMessaage=pendingGhostMessage_;

@synthesize sharingView=shareingView_;

@synthesize selectedScenario=selectedScenario_;
@synthesize selectedGameType=selectedGameType_;
@synthesize selectedCurrencyMode=selectedCurrencyMode_;
@synthesize selectedDifficultyLevel=selectedDifficultyLevel_;

//---------------------------------------------------------------------------------------------------------
//
// INIT
//
//---------------------------------------------------------------------------------------------------------


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSLog(@"GameViewController didload");
	
	[self setDelegate:self];

	gameModel_ = [NUGameModel sharedGameModel];

	[self setNavigationBarHidden:YES];
	[self setupNotifications];
	[self checkDefaults];
	
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

-(void)applicationWillResignActive:(NSNotification *)notification {
	NSLog(@"RESIGNING ACTIVE");
	
	BOOL saveState = [gameModel_ saveUserData];
	
	if(!saveState) {
		NSLog(@"Couldn't save user data");
	}
}

-(void) checkDefaults {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults synchronize];
	
	if([defaults boolForKey:kSettingsReset] == YES) {
		// TODO show sheet to confirm reset
		NSLog(@"GOING TO RESET");
		pendingGhostMessage_ = @"All settings have been reset.";
	}
	
	[gameModel_ configureFromUserDefaults:[NSUserDefaults standardUserDefaults]];
	
	[self continueViewDidLoad];
}

// TOD this needs to be merged w/ above method
-(void)refeshDefaults {
	NSLog(@"Refreshing defaults");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults synchronize];
	
	if([defaults boolForKey:kSettingsReset] == YES) {
		NSLog(@"GOING TO RESET");
		pendingGhostMessage_ = @"All settings have been reset.";
		// TODO show sheet to confirm reset
	}
	
	[gameModel_ configureFromUserDefaults:[NSUserDefaults standardUserDefaults]];
}

-(void)continueViewDidLoad {
	[self showTitleScreen];
	
	if(pendingGhostMessage_) {
		[self showGhostViewWithTitle:pendingGhostMessage_];
	}
}

-(void)setupNotifications {	
	// title screen
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTitleScreen) name:kNotificationShowTitle object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectFreePlayCountingInteraction) name:kNotificationStartGameFree object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startGamePlay) name:kNotificationStartGamePlay object:nil];
	
	// game type menu
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMoneyCountingGame) name:kNotificationSelectMoneyCountingGame object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMoneyIDGame) name:kNotificationSelectMoneyIDGame object:nil];
	
	// difficulty menu
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectEasyGame) name:kNotificationSelectEasyGame object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMediumGame) name:kNotificationSelectMediumGame object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectHardGame) name:kNotificationSelectHardGame object:nil];
	
	// navigate back from a sub view, i think there's a more direct way to do this
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popCurrentSubMenuOff) name:kNotificationPopCurrentSubMenuOff object:nil];
	
	// counting interaction
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endCurrentGameInteraction) name:kNotificationEndCurrentGame object:nil];
	
	// app
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDebugMessage:) name:kNotificationShowDebugMessage object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postMessageToFaceBook:) name:kNotificationPostFacebookMessage object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playSoundFile:) name:kNotificationPlaySound object:nil];
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSInteger)supportedInterfaceOrientations{
    return 24;
}

// depreciated in ios6!
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

//---------------------------------------------------------------------------------------------------------
//
// COMMON UTIL VIEWS
//
//---------------------------------------------------------------------------------------------------------

-(void) showDebugMessage:(NSNotification*) notification {
	if(!kDebugModeEnabled) return;
	
	NSDictionary *userInfo = notification.userInfo;
	NSString *message =userInfo[@"message"];
	[self showGhostViewWithTitle:message];
}

-(void)showGhostViewWithTitle:(NSString *)title {
	if(ghostView_) [ghostView_ hide];
	ghostView_ = [[OLGhostAlertView alloc] initWithTitle:title];
	[ghostView_ show];
	pendingGhostMessage_ = nil;
}

-(void) playSoundFile:(NSNotification*)sndfile
{
	NSDictionary *userInfo = sndfile.userInfo;
	NSString *fName =userInfo[@"soundfile"];
	
	if(audioPlayer_) {
		[audioPlayer_ stop];
		audioPlayer_ = nil;
	}
	
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [NSString stringWithFormat:@"%@.aiff", fName]]];
	
	NSError *error;
	audioPlayer_ = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	
	if (audioPlayer_ == nil) {
		NSLog(@"playSound error - %@", [error description]);
	} else {
		//NSLog(@"Playing file: %@",fName);
		[audioPlayer_ play];
	}
}

-(void) postMessageToFaceBook:(NSNotification*)fbmessage {
	NSDictionary *userInfo = fbmessage.userInfo;
	NSString *message =userInfo[@"message"];

	if(shareingView_) {
		[shareingView_ removeFromParentViewController];
		shareingView_ = nil;
	}
	
	shareingView_ = [[UIActivityViewController alloc]initWithActivityItems:@[message] applicationActivities:nil];
	if(![gameModel_ getCurrentPlayerSocialEnabled]) {
		shareingView_.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard];
	}
	[self presentViewController:shareingView_ animated:YES completion:nil];
}

//---------------------------------------------------------------------------------------------------------
//
// COMMON
//
//---------------------------------------------------------------------------------------------------------

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	//NSLog(@"will show %@",viewController);
	currentView_ = viewController;
	
}

-(void)popCurrentSubMenuOff {
	[self popViewControllerAnimated:YES];
}

//---------------------------------------------------------------------------------------------------------
//
// TITLE
//
//---------------------------------------------------------------------------------------------------------

-(void)showTitleScreen {
	titleView_ = [[NUTitleScreenViewController alloc] init];
	[self pushViewController:titleView_ animated:NO];
}

-(void) startGamePlay {
	[self showGameTypeMenu];
}

-(void) handleGameTypeSelection {
	if(selectedGameType_ == GameMoneyIdentify) {
		[self beginMoneyIDGame];
	} else if(selectedGameType_ == GameFree) {
		[self beginFreePlayCountingInteraction];
	} else if(selectedGameType_ == GameCounting) {
		[self showDifficultyMenu];
	} else {
		NSLog(@"The game type selection is not defined");
	}
}

-(void) handleDifficultySelection {
	if(selectedGameType_ == GameCounting) {
		[self beginCountingInteraction];
	} else {
		NSLog(@"The difficulty and game type selection isn't defined");
	}
}


//---------------------------------------------------------------------------------------------------------
//
// GAME TYPE MENU
//
//---------------------------------------------------------------------------------------------------------

-(void)showGameTypeMenu {	
	gameTypeView_ = [[NUGameTypeSelectViewController alloc] init];
	[self pushViewController:gameTypeView_ animated:YES];
}

//---------------------------------------------------------------------------------------------------------
//
// DIFFICULTY MENU
//
//---------------------------------------------------------------------------------------------------------

-(void)showDifficultyMenu {
	difficultyView_ = [[NUDifficultySelectViewController alloc] init];
	[self pushViewController:difficultyView_ animated:YES];
}

-(void)selectEasyGame {
	selectedDifficultyLevel_ = DifficultyEasy;
	[self handleDifficultySelection];
}

-(void)selectMediumGame {
	selectedDifficultyLevel_ = DifficultyMedium;
	[self handleDifficultySelection];
}

-(void)selectHardGame {
	selectedDifficultyLevel_ = DifficultyHard;
	[self handleDifficultySelection];
}

//---------------------------------------------------------------------------------------------------------
//
// MONEY ID
//
//---------------------------------------------------------------------------------------------------------

-(void) selectMoneyIDGame {
	selectedGameType_ = GameMoneyIdentify;
	[self handleGameTypeSelection];
}

-(void) beginMoneyIDGame {
	moneyIDView_ = [[NUMoneyIDViewController alloc] init];
	[self pushViewController:moneyIDView_ animated:YES];
}


//---------------------------------------------------------------------------------------------------------
//
// COUNTING 
//
//---------------------------------------------------------------------------------------------------------

-(void) selectFreePlayCountingInteraction {
	selectedGameType_ = GameFree;
	[self handleGameTypeSelection];
}

-(void)selectMoneyCountingGame {
	selectedGameType_ = GameCounting;
	[self showDifficultyMenu];
}

-(void) beginFreePlayCountingInteraction {
	NUCountingGameModel *model = [[NUCountingGameModel alloc] init];
	
	model.scenario = nil;
	model.currentGameType = selectedGameType_;
	model.currentDifficulty = DifficultyHard;
	model.currentCurrencyMode = PaperAndCoin;
	
	[self showCountingInteractionWithModel:model];
}

-(void)beginCountingInteraction {
	NUCountingGameModel *model = [[NUCountingGameModel alloc] init];
	
	model.scenario = nil;
	model.currentGameType = selectedGameType_;
	model.currentDifficulty = selectedDifficultyLevel_;
	model.currentCurrencyMode = CoinOnly;
	
	if(selectedDifficultyLevel_ == DifficultyMedium) model.currentCurrencyMode = PaperOnly;
	else if(selectedDifficultyLevel_ == DifficultyHard) model.currentCurrencyMode = PaperAndCoin;

	[self showCountingInteractionWithModel:model];
}

-(void)showCountingInteractionWithModel:(NUCountingGameModel *)model {
	[self disposeOfCountingView];
	
	countingView_ = [[NUCountingViewController alloc]initWithModel:model];
	[self pushViewController:countingView_ animated:YES];
}

-(void)disposeOfCountingView {
	if(countingView_) {
		countingView_ = nil;
	}
}

-(void) endCurrentGameInteraction {
	[self popToViewController:titleView_ animated:YES];
}

//---------------------------------------------------------------------------------------------------------
//
// dealloc
//
//---------------------------------------------------------------------------------------------------------


-(void) dealloc {
	ghostView_ = nil;
	currentView_ = nil;
	gameModel_ = nil;
	titleView_ = nil;
	gameTypeView_ = nil;
	difficultyView_ = nil;
	countingView_ = nil;
	moneyIDView_ = nil;
	audioPlayer_ = nil;
	shareingView_ = nil;
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
		
	[[[self view] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


@end
