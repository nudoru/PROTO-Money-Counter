//
//  NUGameAlertMessage.h
//  MoneyCounter XS
//
//  Created by Matt Perkins on 8/24/12.
//
//

#import <UIKit/UIKit.h>
#import "NUGameAlertType.h"
#import "NUGameType.h"
#import "NUNotificationDefines.h"
#import "NUGameModel.h"
#import "NUMessageTexts.h"

@interface NUGameAlertMessage : UIViewController

- (IBAction)onCloseTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starIcon;
@property (weak, nonatomic) IBOutlet UIImageView *clockIcon;
@property (weak, nonatomic) IBOutlet UIImageView *gameIcon;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gamesLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftStar;
@property (weak, nonatomic) IBOutlet UIImageView *middleStar;
@property (weak, nonatomic) IBOutlet UIImageView *rightStar;

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;


@property (nonatomic) GameAlertType alertType;
@property (nonatomic) GameType fromGameType;
@property (nonatomic) NSString *messageTitle;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *button;
@property (nonatomic) int numStars;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic) UINib *messageNIB;

-(id)initWithType:(GameAlertType)type fromGameType:(GameType)gameType title:(NSString *)t message:(NSString *)m button:(NSString *) b stars:(int)stars;
- (IBAction)onFacebookTap:(id)sender;

@end
