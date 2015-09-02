//
//  NUGameAlertType.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/29/12.
//
//

#import <Foundation/Foundation.h>

@interface NUGameAlertType : NSObject


typedef enum {
    GameAlertGeneral,
	GameAlertSuccess,
	GameAlertFail,	
} GameAlertType;

@end
