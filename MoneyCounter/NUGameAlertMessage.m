//
//  NUGameAlertMessage.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/24/12.
//
//

#import "NUGameAlertMessage.h"
#import "Social/Social.h"

@interface NUGameAlertMessage ()

@end

@implementation NUGameAlertMessage
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize leftStar;
@synthesize middleStar;
@synthesize rightStar;
@synthesize facebookButton;
@synthesize alertType;
@synthesize messageTitle;
@synthesize message;
@synthesize button;
@synthesize numStars;
@synthesize closeButton;
@synthesize starLabel;
@synthesize timeLabel;
@synthesize gamesLabel;
@synthesize fromGameType;
@synthesize messageNIB;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithType:(GameAlertType)type fromGameType:(GameType)gameType title:(NSString *)t message:(NSString *)m button:(NSString *) b stars:(int)stars{
	self = [super init];
	if(self) {
		button = b;
		message = m;
		messageTitle = t;
		alertType = type;
		fromGameType = gameType;
		numStars = stars;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	messageNIB = [UINib nibWithNibName:[self getAlertNIBFromType] bundle:[NSBundle mainBundle]];
	[messageNIB instantiateWithOwner:self options:nil];
	
	if([self titleLabel]) [[self titleLabel] setText:messageTitle];
	
	[[self messageLabel] setText:message];
	[[self closeButton] setTitle:button forState:UIControlStateNormal];
	
	if(leftStar && middleStar && rightStar) {
		[leftStar setHidden:YES];
		[middleStar setHidden:YES];
		[rightStar setHidden:YES];
		if(numStars >= 1) [leftStar setHidden:NO];
		if(numStars >= 2) [rightStar setHidden:NO];
		if(numStars == 3) [middleStar setHidden:NO];
	}
	
	// set stats at the bottom of the popup
	if(alertType == GameAlertSuccess) {
		[starLabel setText:[NSString stringWithFormat:@"%@",[[NUGameModel sharedGameModel] getCurrentPlayerStars]]];
		[timeLabel setText:[[NUGameModel sharedGameModel] getCurrentPlayerGameTimeHHMMSS]];
		[gamesLabel setText:[NSString stringWithFormat:@"%@",[[NUGameModel sharedGameModel] getCurrentPlayerCorrectMatches]]];
	}
	
	if(fromGameType == GameScenario) {
		[facebookButton setHidden:NO];
		//NSLog(@"From a challenge");
	} else {
		//NSLog(@"Not from a challenge");
		[facebookButton setHidden:YES];
	}
}

-(NSString *)getAlertNIBFromType {
	switch (alertType) {
		case GameAlertSuccess:
			return @"NUGameAlertMessageSuccess";
			break;
		case GameAlertFail:
			return @"NUGameAlertMessageFail";
			break;
		default:
			return @"NUGameAlertMessageGeneral";
			break;
	}
}


- (IBAction)onFacebookTap:(id)sender {
	NSDictionary *fbmessage = @{@"message": kMessageFacebookChallengeCompleted};
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPostFacebookMessage object:nil userInfo:fbmessage];
}

-(void)sendDebugMessage:(NSString *)text {
	NSDictionary *dbgmessage = @{@"message": text};
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowDebugMessage object:nil userInfo:dbgmessage];
}

- (IBAction)onCloseTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificiationDismissGameAlert object:self];
}

- (void)viewDidUnload
{
    messageNIB = nil;
	
	[self setTitleLabel:nil];
    [self setMessageLabel:nil];
	[self setCloseButton:nil];
    [self setStarLabel:nil];
    [self setTimeLabel:nil];
    [self setGamesLabel:nil];
    [self setStarIcon:nil];
    [self setClockIcon:nil];
    [self setGameIcon:nil];
    [self setFacebookButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
