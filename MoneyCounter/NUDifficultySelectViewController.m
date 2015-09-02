//
//  NUDifficultySelectViewController.m
//  MoneyCounter
//
//  Created by Matt Perkins on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUDifficultySelectViewController.h"

@interface NUDifficultySelectViewController ()

@end

@implementation NUDifficultySelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
	// not showing nav bar anymore
	//[self setTitle:@"Select Difficulty"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)onEasyTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSelectEasyGame object:self];
}

- (IBAction)onMediumTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSelectMediumGame object:self];
}

- (IBAction)onHardTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSelectHardGame object:self];
}

- (IBAction)onBackTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPopCurrentSubMenuOff object:self];

}
@end
