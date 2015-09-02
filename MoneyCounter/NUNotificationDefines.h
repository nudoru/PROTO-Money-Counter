//
//  NUNotificationDefines.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 9/17/12.
//
//

#import <Foundation/Foundation.h>

#define kNotificationShowTitle @"showTitle"
#define kNotificationStartGameFree @"startGameFree"
#define kNotificationStartGamePlay @"startGamePlay"

#define kNotificationEndCurrentGame @"endCurrentGame"

#define kNotificationSelectMoneyCountingGame @"selectMoneyCountingGame"
#define kNotificationSelectMoneyIDGame @"selectMoneyIDGame"

// difficulty menu
#define kNotificationSelectEasyGame @"selectEasyGame"
#define kNotificationSelectMediumGame @"selectMediumGame"
#define kNotificationSelectHardGame @"selectHardGame"

#define kNotificationPopCurrentSubMenuOff @"popCurrentSubMenuOff"
#define kNotificationShowDebugMessage @"debugMessage"
#define kNotificationPostFacebookMessage @"postFacebookMessage"
#define kNotificationPlaySound @"playSoundFile"

//in game
#define kNotificiationDismissGameAlert @"gameAlertMessageDismiss"

@interface NUNotificationDefines : NSObject

@end
