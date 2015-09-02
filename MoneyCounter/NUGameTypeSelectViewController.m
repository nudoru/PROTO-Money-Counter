//
//  NUGameTypeSelectViewController.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/23/12.
//
//

#import "NUGameTypeSelectViewController.h"

@interface NUGameTypeSelectViewController ()

@end

@implementation NUGameTypeSelectViewController

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

- (IBAction)onBackTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPopCurrentSubMenuOff object:self];
}

- (IBAction)onCountingGameTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSelectMoneyCountingGame object:self];
}

- (IBAction)onMoneyIDGameTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSelectMoneyIDGame object:self];
}
@end
