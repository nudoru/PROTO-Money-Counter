//
//  NUAppDelegate.m
//  MoneyCounter
//
//  Created by Matt Perkins on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUAppDelegate.h"
#import "NUCountingViewController.h"
#import "NUDifficultyLevel.h"
#import "NUGameType.h"
#import <AVFoundation/AVFoundation.h>

@implementation NUAppDelegate

@synthesize window = _window;
@synthesize viewController=viewController_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	NSDictionary *defaults = @{kSettingsChildName: @"No Name",
							  kSettingsChildAge: @"a57",
							  kSettingsChildSocialEnabled: @NO,
							  kSettingsReset: @NO};
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
	
	CGRect sizedBounds = CGRectMake(0, 0, 320, 480);
	self.window = [[UIWindow alloc] initWithFrame:sizedBounds]; //[UIScreen mainScreen] bounds
    // Override point for customization after application launch.
	
	//[self createViewController];
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
	
	//http://stackoverflow.com/questions/7290418/avaudioplayer-error-loading-file?rq=1
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
	
    return YES;
}

-(void) createViewController {
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
	
	if(viewController_) viewController_ = nil;

	viewController_ = [[NUGameViewController alloc] init];
	
	[[self window] setRootViewController:viewController_];	
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	if(viewController_) [viewController_ refeshDefaults];
}

//http://developer.apple.com/library/ios/#documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/AdvancedAppTricks/AdvancedAppTricks.html#//apple_ref/doc/uid/TP40007072-CH7-SW50
//http://skookum.com/blog/open-an-ios-app-from-an-email/

// app is already loaded and will regain forground
-(BOOL) application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	return YES;
}

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	NSLog(@"Launched with URL: %@", url.absoluteString);
	
	//NSDictionary *userDict = [self urlPathToDictionary:url.absoluteString];
	
	UIAlertView *mesg = [[UIAlertView alloc] initWithTitle:@"openURL,source app..." message:@"Opened me from a URL" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[mesg show];
	
	return YES;
}

/*
 -(NSDictionary *)urlPathToDictionary:(NSString *)path
 Takes a url in the form of: your_prefix://this_item/value1/that_item/value2/some_other_item/value3
 And turns it into a dictionary in the form of:
 {
 this_item: @"value1",
 that_item: @"value2",
 some_other_item: @"value3"
 }
 
 Handles everything properly if there is a trailing slash or not.
 Returns `nil` if there aren't the proper combinations of keys and pairs (must be an even number)
 
 NOTE: This example assumes you're using ARC. If not, you'll need to add your own autorelease statements.
 */

-(NSDictionary *)urlPathToDictionary:(NSString *)path
{
	//Get the string everything after the :// of the URL.
	NSString *stringNoPrefix = [[path componentsSeparatedByString:@"://"] lastObject];
	//Get all the parts of the url
	NSMutableArray *parts = [[stringNoPrefix componentsSeparatedByString:@"/"] mutableCopy];
	//Make sure the last object isn't empty
	if([[parts lastObject] isEqualToString:@""])[parts removeLastObject];
	
	if([parts count] % 2 != 0)//Make sure that the array has an even number
		return nil;
	
	//We already know how many values there are, so don't make a mutable dictionary larger than it needs to be.
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:([parts count] / 2)];
	
	//Add all our parts to the dictionary
	for (int i=0; i<[parts count]; i+=2) {
		dict[parts[i]] = parts[i+1];
	}
	
	//Return an NSDictionary, not an NSMutableDictionary
	return [NSDictionary dictionaryWithDictionary:dict];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	
	viewController_ = nil;
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[self createViewController];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
