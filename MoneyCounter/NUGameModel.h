//
//  NUGameModel.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/22/12.
//
//

#import <Foundation/Foundation.h>

#import "NUUserModel.h"

#define kSettingsChildName @"childName"
#define kSettingsChildAge @"childAge"
#define kSettingsChildSocialEnabled @"socialEnabled"
#define kSettingsReset @"settingsReset"

#define kStarValue 0.25

@interface NUGameModel : NSObject

@property NUUserModel *currentPlayer;

@property NSString *currentDifficulty;
@property NSString *currentGameType;

@property BOOL settingsReset;

@property NSString *OLBUserName;
@property NSString *OLBSiteKey;
@property BOOL OLBEnabled;
@property NSString *OLBSourceAccount;
@property NSString *OLBDestinationAccount;


+(NUGameModel *)sharedGameModel;

-(void)configureFromUserDefaults:(NSUserDefaults *)defaults;
-(void)fullReset;
-(void)saveUpdatedDefaults;

-(float) getStarValue;
-(float) getValueForNumStars:(int)stars;
-(void) cashInAllPlayerStars;

-(void)incrementCurrentPlayerChallengesPresented;
-(void)incrementCurrentPlayerPerfectMatches;
-(void)incrementCurrentPlayerCorrectMatches;
-(void)addStarsToCurrentPlayer:(int) stars;
-(void)addGameTimeToCurrentPlayer:(NSTimeInterval) time;
-(NSString *)playerDataFilePath;
-(BOOL) saveUserData;

-(NSString *)getCurrentPlayerName;
-(NSString *)getCurrentPlayerAge;
-(BOOL) getCurrentPlayerSocialEnabled;
-(NSNumber *)getCurrentPlayerStars;
-(NSNumber *)getCurrentPlayerChallengesPresented;
-(NSNumber *)getCurrentPlayerCorrectMatches;
-(NSString *)getCurrentPlayerGameTimeHHMMSS;

@end
