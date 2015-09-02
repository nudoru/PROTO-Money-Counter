//
//  NUUserModel.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/22/12.
//
//

#import <Foundation/Foundation.h>
#import "NUNotificationDefines.h"

#define kUserDataFile @"userdata.archive"
#define kUserStars @"stars"
#define kUserGamesPlayed @"gamesplayed"
#define kUserChallengesPresented @"challengesPresented"
#define kUserCorrectMatches @"correctMatches"
#define kUserPerfectMatches @"perfectMatches"
#define kUserTimePlayingGame @"timePlayingGame"
#define kUserSocialEnabled @"socialEnabled"

@interface NUUserModel : NSObject <NSCoding>

@property NSString *firstName;
@property NSString *lastName;
@property NSString *name;
@property NSString *age;
@property NSNumber *stars;
@property NSNumber *gamesPlayed;
@property NSNumber *challengesPresented;
@property NSNumber *correctMatches;
@property NSNumber *perfectMatches;
@property NSTimeInterval timePlayingGame;
@property BOOL socialEnabled;

-(void)fullReset;
-(void)resetNumericProperties;
-(void)incrementGamesPlayed;
-(void)incrementChallengesPresented;
-(void)incrementCorrectMatches;
-(void)incrementPerfectMatches;
-(void)addStars:(int) newstars;
-(void)addToTimePlayingGame:(NSTimeInterval)time;

-(NSNumber *) incrementNSNumber:(NSNumber *)number;

-(void)sendDebugMessage:(NSString *)text;
@end
