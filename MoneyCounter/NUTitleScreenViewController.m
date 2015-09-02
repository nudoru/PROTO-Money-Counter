//
//  NUTitleScreenViewController.m
//  MoneyCounter
//
//  Created by Matt Perkins on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUTitleScreenViewController.h"
#import "NUGameViewController.h"
#import "NUUserModel.h"

@interface NUTitleScreenViewController ()

@end

@implementation NUTitleScreenViewController
@synthesize playerNameLabel;

-(id) init{
	self = [super init];
	if(self) {
		//
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
	[playerNameLabel setText:[NSString stringWithFormat:@"Welcome back, %@!",[[NUGameModel sharedGameModel] getCurrentPlayerName]]];
}

- (IBAction)onJustCountTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStartGameFree object:self];
}

- (IBAction)onPlayTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStartGamePlay object:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidUnload {
    [self setPlayerNameLabel:nil];
    [super viewDidUnload];
}
@end
