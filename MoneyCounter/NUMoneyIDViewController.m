//
//  NUMoneyIDViewController.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 11/2/12.
//
//

#import "NUMoneyIDViewController.h"

@interface NUMoneyIDViewController ()

@end

@implementation NUMoneyIDViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onStopTap:(id)sender {
	[super showQuitActionSheet];
}
@end
