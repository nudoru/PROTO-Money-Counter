//
//  NUMessageTexts.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 10/24/12.
//
//

#import <Foundation/Foundation.h>
#import "NUApplicationValues.h"

#define kMessageGameQuit @"Are you sure you want to quit the current game?"

#define kMessageCountingTooHigh @"That was too much money! Try again."
#define kMessageCountingPerfectMatch @"You made a perfect match! Great job!"
#define kMessageCountingMatch @"You made a match! Great job!"

#define kMessageMoneyIDAllMatches @"Great job! You found them all!"
#define kMessageMoneyIDPartialMatches @"Good job!"
#define kMessageMoenyIDNoMatches @"Better luck next time."

@interface NUMessageTexts : NSObject

@end
