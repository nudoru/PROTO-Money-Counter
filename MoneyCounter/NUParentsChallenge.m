//
//  NUParentsChallenge.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/28/12.
//
//

#import "NUParentsChallenge.h"

@interface NUParentsChallenge ()

@end

@implementation NUParentsChallenge

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)onBackTap:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"popCurrentSubMenuOff" object:self];
}
@end
