//
//  NUUserModel.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/22/12.
//	Singleton method from: http://www.duckrowing.com/2011/11/09/using-the-singleton-pattern-in-objective-c-part-2/
//
//

#import "NUUserModel.h"

@implementation NUUserModel

@synthesize firstName;
@synthesize lastName;
@synthesize name;
@synthesize age;
@synthesize stars;
@synthesize gamesPlayed;
@synthesize challengesPresented;
@synthesize correctMatches;
@synthesize perfectMatches;
@synthesize timePlayingGame;
@synthesize socialEnabled;

- (id)init {
	self = [super init];
	
	if (self) {
		[self resetNumericProperties];
	}

    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
	self = [self init];
	if(self) {
		[self setStars:@([aDecoder decodeIntForKey:kUserStars])];
		[self setGamesPlayed:@([aDecoder decodeIntForKey:kUserGamesPlayed])];
		[self setChallengesPresented:@([aDecoder decodeIntForKey:kUserChallengesPresented])];
		[self setCorrectMatches:@([aDecoder decodeIntForKey:kUserCorrectMatches])];
		[self setPerfectMatches:@([aDecoder decodeIntForKey:kUserPerfectMatches])];
		[self setTimePlayingGame:[aDecoder decodeFloatForKey:kUserTimePlayingGame]];
		[self setSocialEnabled:[aDecoder decodeBoolForKey:kUserSocialEnabled]];
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInt:[stars intValue] forKey:kUserStars];
	[aCoder encodeInt:[gamesPlayed intValue] forKey:kUserGamesPlayed];
	[aCoder encodeInt:[challengesPresented intValue] forKey:kUserChallengesPresented];
	[aCoder encodeInt:[correctMatches intValue] forKey:kUserCorrectMatches];
	[aCoder encodeInt:[perfectMatches intValue] forKey:kUserPerfectMatches];
	[aCoder encodeFloat:timePlayingGame forKey:kUserTimePlayingGame];
	[aCoder encodeBool:socialEnabled forKey:kUserSocialEnabled];
}

-(void)fullReset {
	NSLog(@"User Model RESET");
	name = @"";
	age = @"";
	[self resetNumericProperties];
}

-(void)resetNumericProperties {
	stars = @0;
	gamesPlayed = @0;
	challengesPresented = @0;
	correctMatches = @0;
	perfectMatches = @0;
	timePlayingGame = 0;
	socialEnabled = NO;
}

-(void)incrementGamesPlayed {
	gamesPlayed = [self incrementNSNumber:gamesPlayed];
	NSLog(@"Num games started: %@", gamesPlayed);
	[self sendDebugMessage:[NSString stringWithFormat:@"Number games started: %@", gamesPlayed]];
}

-(void)incrementChallengesPresented {
	challengesPresented = [self incrementNSNumber:challengesPresented];
	NSLog(@"Challenges presented: %@", challengesPresented);
	[self sendDebugMessage:[NSString stringWithFormat:@"Challenges presented: %@", challengesPresented]];
}

-(void)incrementCorrectMatches {
	correctMatches = [self incrementNSNumber:correctMatches];
	NSLog(@"Num correct matches: %@", correctMatches);
	[self sendDebugMessage:[NSString stringWithFormat:@"Number corr matches: %@", correctMatches]];
}

-(void)incrementPerfectMatches {
	perfectMatches = [self incrementNSNumber:perfectMatches];
	NSLog(@"Num perfect matches: %@", perfectMatches);
	[self sendDebugMessage:[NSString stringWithFormat:@"Number PERF matches: %@", perfectMatches]];
}

-(void)addStars:(int) newstars {
	int currentstars = [stars intValue];
	stars = @(currentstars + newstars);
	NSLog(@"Stars now: %@", stars);
	[self sendDebugMessage:[NSString stringWithFormat:@"Stars now: %@", stars]];
}


-(NSNumber *) incrementNSNumber:(NSNumber *)number {
	int num = [number intValue];
	number = @(num + 1);
	return number;
}

-(void)addToTimePlayingGame:(NSTimeInterval)time
{
	timePlayingGame += time;
}

-(void)sendDebugMessage:(NSString *)text {
	NSDictionary *message = @{@"message": text};
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowDebugMessage object:nil userInfo:message];
}

@end
