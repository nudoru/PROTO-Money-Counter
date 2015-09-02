//
//  NUGameType.h
//  MoneyCounter
//
//  Created by Matt Perkins on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUGameType : NSObject

typedef enum {
	GameFree,
	GameCounting,
	GameStore,
	GameBudget,
	GameSequence,
	GameMath,
	GameScenario,
	GameMoneyIdentify,
} GameType;

@end
