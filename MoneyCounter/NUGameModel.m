//
//  NUGameModel.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/22/12.
//	Singleton method from: http://www.duckrowing.com/2011/11/09/using-the-singleton-pattern-in-objective-c-part-2/
//
//

#import "NUGameModel.h"
#import "NUUserModel.h"

static NUGameModel *sharedInstance = nil;
static dispatch_queue_t serialQueue;

@implementation NUGameModel

@synthesize currentPlayer=currentPlayer_;

@synthesize currentDifficulty=currentDifficulty_;
@synthesize currentGameType=currentGameType_;

@synthesize settingsReset=settingsReset_;
@synthesize OLBUserName=OLBUserName_;
@synthesize OLBSiteKey=OLBSiteKey_;
@synthesize OLBEnabled=OLBEnabled_;
@synthesize OLBSourceAccount=OLBSourceAccount_;
@synthesize OLBDestinationAccount=OLBDestinationAccount_;

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceQueue;
	
    dispatch_once(&onceQueue, ^{
        serialQueue = dispatch_queue_create("com.nudoru.SerialQueue", NULL);
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
	
    return sharedInstance;
}

+ (NUGameModel *)sharedGameModel {
    static dispatch_once_t onceQueue;
	
    dispatch_once(&onceQueue, ^{
        sharedInstance = [[NUGameModel alloc] init];
    });
	
    return sharedInstance;
}

- (id)init {
    id __block obj;
	
    dispatch_sync(serialQueue, ^{
        obj = [super init];
        if (obj) {
			NSString *userDataFile = [self playerDataFilePath];
			
			currentPlayer_ = [NSKeyedUnarchiver unarchiveObjectWithFile:userDataFile];
			if(!currentPlayer_) currentPlayer_ = [[NUUserModel alloc]init];
        }
    });
	
    self = obj;
    return self;
}

//---------------------------------------------------------------------------------------------------------
//
// GAMES AND DEFAULTS
//
//---------------------------------------------------------------------------------------------------------

-(void)configureFromUserDefaults:(NSUserDefaults *)defaults
{
	dispatch_sync(serialQueue, ^{
        NSLog(@"configuring from userdefaults %@",defaults);
		
		settingsReset_ = [defaults boolForKey:kSettingsReset];
		if(settingsReset_) {
			[self fullReset];
			return;
		}
		
	  [currentPlayer_ setName:[defaults valueForKey:kSettingsChildName]];
	  [currentPlayer_ setAge:[defaults valueForKey:kSettingsChildAge]];
	  [currentPlayer_ setSocialEnabled:[defaults boolForKey:kSettingsChildSocialEnabled]];
	   
		//settingsReset_ = NO;
	  //[[NSUserDefaults standardUserDefaults] setBool:settingsReset_ forKey:kSettingsReset];
    });
}

-(void)fullReset {
	NSLog(@"Game Model REEST");
	
	OLBUserName_ = @"reset";
	OLBSiteKey_ = @"";
	OLBEnabled_ = NO;
	OLBSourceAccount_ = @"";
	OLBDestinationAccount_ = @"";
	
	[[self currentPlayer] fullReset];
	
	settingsReset_ = NO;
	[self saveUpdatedDefaults];
}

-(void) saveUpdatedDefaults {
	NSLog(@"Saving defaults");
	[[NSUserDefaults standardUserDefaults] setValue:currentPlayer_.name forKey:kSettingsChildName];
	[[NSUserDefaults standardUserDefaults] setValue:currentPlayer_.age forKey:kSettingsChildAge];
	[[NSUserDefaults standardUserDefaults] setBool:currentPlayer_.socialEnabled forKey:kSettingsChildSocialEnabled];
	[[NSUserDefaults standardUserDefaults] setBool:settingsReset_ forKey:kSettingsReset];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


//---------------------------------------------------------------------------------------------------------
//
// CURRENT PLAYER
//
//---------------------------------------------------------------------------------------------------------

- (NSString *)playerDataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return [documentsDirectory stringByAppendingPathComponent:kUserDataFile];
}

-(BOOL) saveUserData {
	NSString *path = [self playerDataFilePath];
	return [NSKeyedArchiver archiveRootObject:currentPlayer_ toFile:path];
}

-(NSString *)getCurrentPlayerName{
	return [currentPlayer_ name];
}

-(NSString *)getCurrentPlayerAge{
	return [currentPlayer_ age];
}
-(BOOL) getCurrentPlayerSocialEnabled {
	return [currentPlayer_ socialEnabled];
}

-(NSNumber *)getCurrentPlayerStars{
	return [currentPlayer_ stars];
}


-(NSNumber *)getCurrentPlayerChallengesPresented{
	return [currentPlayer_ challengesPresented];
}

-(NSNumber *)getCurrentPlayerCorrectMatches {
	return [currentPlayer_ correctMatches];
}

-(void)incrementCurrentPlayerChallengesPresented {
	[currentPlayer_ incrementChallengesPresented];
}

-(void)incrementCurrentPlayerCorrectMatches {
	[currentPlayer_ incrementCorrectMatches];
}

-(void)incrementCurrentPlayerPerfectMatches {
	[currentPlayer_ incrementPerfectMatches];
}

-(void)addStarsToCurrentPlayer:(int) stars {
	[currentPlayer_ addStars:stars];
}

-(void)addGameTimeToCurrentPlayer:(NSTimeInterval) time
{
	[currentPlayer_ addToTimePlayingGame:time];
	NSLog(@"Total time playing: %f",[currentPlayer_ timePlayingGame]);
}

-(NSString *)getCurrentPlayerGameTimeHHMMSS {
	return [self convertSecondsToHHMMSS:[currentPlayer_ timePlayingGame]];
}

//http://stackoverflow.com/questions/1237778/how-do-i-break-down-an-nstimeinterval-into-year-months-days-hours-minutes-an
- (NSString *)convertSecondsToHHMMSS:(float)seconds {
	
    // Return variable.
    NSString *result = @"";
	
    // Int variables for calculation.
    int secs = floor(seconds);
    int tempHour    = 0;
    int tempMinute  = 0;
    int tempSecond  = 0;
	
    NSString *hour      = @"";
    NSString *minute    = @"";
    NSString *second    = @"";
	
    // Convert the seconds to hours, minutes and seconds.
    tempHour    = secs / 3600;
    tempMinute  = secs / 60 - tempHour * 60;
    tempSecond  = secs - (tempHour * 3600 + tempMinute * 60);
	
    hour    = [@(tempHour) stringValue];
    minute  = [@(tempMinute) stringValue];
    second  = [@(tempSecond) stringValue];
	
    // Make time look like 00:00:00 and not 0:0:0
    /*if (tempHour < 10) {
	 hour = [@"0" stringByAppendingString:hour];
	 }
	 
	 if (tempMinute < 10) {
	 minute = [@"0" stringByAppendingString:minute];
	 }
	 
	 if (tempSecond < 10) {
	 second = [@"0" stringByAppendingString:second];
	 }*/
	
    if (tempHour == 0) {
        //NSLog(@"Result of Time Conversion: %@m %@s", minute, second);
        result = [NSString stringWithFormat:@"%@m %@s", minute, second];
    } else {
        //NSLog(@"Result of Time Conversion: %@h %@m %@s", hour, minute, second);
        result = [NSString stringWithFormat:@"%@h %@m %@s",hour, minute, second];
    }
	
    return result;
}


/*
- (void)setStation:(NSDecimalNumber *)station {
    dispatch_sync(serialQueue, ^{
        if (currentStation != station) {
            currentStation = station;
        }
    });
}

- (NSDecimalNumber *)currentStation {
    NSDecimalNumber __block *cs;
	
    dispatch_sync(serialQueue, ^{
        cs = currentStation;
    });
	
    return cs;
}
*/

@end
