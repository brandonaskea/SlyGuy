//
//  Constants.h
//  Sly Guy
//
//  Created by Brandon Askea on 1/24/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Completion)(BOOL completed);

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/*
 *  MENU CONSTANTS
 */

static CGFloat kMenuContainerCornerRadius = 8;

/*
 *  PLAYER CONSTANTS
 */

static NSString * const kPlayerDefaults = @"PlayerDefaults";    // NSDictionary that holds below keys
static NSString * const kPlayerDefaultsHealth = @"PlayerDefaultsHealth";  // NSNumber with float (1.0 = 100%)
static NSString * const kPlayerDefaultsMoney = @"PlayerDefaultsMoney";   // NSNumber with NSInteger (1 = 1 dollar)
static NSString * const kPlayerDefaultsCar = @"PlayerDefaultsCar";       // NSString The Car (if any) the Player owns
static NSString * const kPlayerDefaultsCurrentLevel = @"PlayerDefaultsCurrentLevel"; // The level that the Player is either currently playing, or the one that needs to be loaded

static CGFloat const kPlayerIndoorZPosition = 5;
static CGFloat const kPlayerOutdoorZPosition = 3;

/*
 *  LAUNCH IMAGE CONSTANTS
 */

static CGFloat kLaunchImageBottomConstraintIncreaseIPhone5AndBelow = 218;
static CGFloat kLaunchImageTopPadding = 20;

/*
 *  GAME CONSTANTS
 */

// PLAYER
static CGFloat kPlayerWidth = 125;
static CGFloat kPlayerHeight = 250;
static CGFloat kPlayerWeight = 70.0; // kilgrams
static CGFloat recenteringAcceleration = 100.0f;

// CONTROLS
static CGFloat kMoveLeftButtonWidth = 180;
static CGFloat kMoveLeftButtonHeight = 120;
static CGFloat kMoveRightButtonWidth = 180;
static CGFloat kMoveRightButtonHeight = 120;

static CGFloat kHealthImageHW = 50;
static CGFloat kHealthImageTopPadding = 50;

static CGFloat kMoneyImageHW = 50;
static CGFloat kMoneyImageTopPadding = 50;

static CGFloat kMoveButtonPadding = 12;

static CGFloat kMovementAmount = 20;
static CGFloat kMovementDuration = 0.33;
static CGFloat kJumpAmountX = 280;
static CGFloat kJumpAmountY = 100;
static CGFloat kShortJumpDuration = 0.40;
static CGFloat kLongJumpDuration = 0.60;

static CGFloat kBoundaryPushBack = 200;


// LEVEL
static CGFloat kScoreLabelPadding = 8;
static CGFloat kScoreLabelHeight = 20;
static CGFloat kWallWidth = 1;

static CGFloat kHealthLabelTopPadding = 50;
static CGFloat kHealthLabelPadding = 10;
static CGFloat kHealthLabelHeight = 20;
static CGFloat kHealthLabelFontSize = 36;

static CGFloat kMoneyLabelPadding = 10;
static CGFloat kMoneyLabelHeight = 20;

//static CGFloat kPlayerFreezeThreshold = 335;
static CGFloat kPlayerFreezeThreshold = 400;


//static CGFloat kScrollingBackgroundWalkingSpeed = 8.33;
static CGFloat kScrollingBackgroundWalkingSpeed = 400;
static CGFloat kScrollingBackgroundDrivingSpeed = 20;
static CGFloat kScrollingBackgroundFlyingSpeed = 30;

static CGFloat kEnvironmentItemsMinimumSpacing = 30;

// ELEMENT CONSTANTS
static CGFloat kElementGlowDuration = 1;
static CGFloat kElementFadeDuration = 0.25;
static NSString * const kElementRepeatGlowKey = @"ElementRepeatGlow";
static NSString * const kForeground1Key = @"Foreground1";
static NSString * const kForeground2Key = @"Foreground2";
static NSString * const kMiddleground1Key = @"Middleground1";
static NSString * const kMiddleground2Key = @"Middleground2";
static NSString * const kBackground1Key = @"Background1";
static NSString * const kBackground2Key = @"Background2";



// SCREEN SEGMENTS

static NSInteger kTotalBackgroundSegmentsCity = 10;

static NSInteger kTotalBackgroundSegmentsBeach = 10;

static NSInteger kTotalForegroundSegmentsSchool = 40;

static NSString  * const kStrangerEncounterBackgroundImage = @"HomeBackgroundImage";

static NSString  * const kGarageBackgroundImage = @"GarageBackgroundImage";

#define kCityBackgroundImages @[@"CityBackgroundImage1", @"CityBackgroundImage2", @"CityBackgroundImage3", @"CityBackgroundImage4"]
#define kCityForegroundImages @[@"CityForegroundImage1-PoleTree", @"CityForegroundImage2-OneTree", @"CityForegroundImage3-TwoTrees", @"CityForegroundImage4-PoleSign"]

#define kBeachBackgroundImages @[@"BeachBackgroundImage1", @"BeachBackgroundImage2", @"BeachBackgroundImage3", @"BeachBackgroundImage4"]
#define kBeachMiddlegroundImages @[@"BeachMiddlegroundImage1", @"BeachMiddlegroundImage2", @"BeachMiddlegroundImage3", @"BeachMiddlegroundImage4"]
#define kBeachForegroundImages @[@"BeachForegroundImage1", @"BeachForegroundImage2", @"BeachForegroundImage3", @"BeachForegroundImage4"]

#define kSchoolForegroundImages @[@"SchoolForegroundImage1", @"SchoolForegroundImage2", @"SchoolForegroundImage3", @"SchoolForegroundImage4", @"SchoolForegroundImage5", @"SchoolForegroundImage6", @"SchoolForegroundImage7", @"SchoolForegroundImage8", @"SchoolForegroundImage9", @"SchoolForegroundImage10"]


/*
 *  MENU CONSTANTS
 */

static CGFloat kSwipeAnimationDuration = 0.15;
static CGFloat kSwipeMenuWidth = 280;
static CGFloat kSwipeMenuCellLabelHeight = 22;
static CGFloat kSwipeMenuCellLabelSidePadding = 10;
static CGFloat kSwipeMenuCellLabelTopBottomPadding = 16;

static CGFloat kSwipeMenuHeaderHeight = 140;
static CGFloat kSwipeMenuHeaderImageHW = 60;
static CGFloat kSwipeMenuHeaderImagePadding = 16;
static CGFloat kSwipeMenuHeaderUsernameLabelHeight = 20;
static CGFloat kSwipeMenuHeaderUsernameLabelPadding = 16;
static CGFloat kSwipeMenuHeaderBottomPadding = 20;

static CGFloat kSwipeMenuHeaderQuotePadding = 12;

/*
 *  CALL TO ACTION CONSTANTS
 */

static CGFloat kCallToActionContainerCornerRadius = 8;
static CGFloat kCallToActionButtonCornerRadius = 6;

/*
 *  FONT CONSTANTS
 */

static NSString * kAlertMessageFont = @"SanFranciscoText-Light";
static CGFloat kAlertMessageFontSize = 17.0;

static NSString * kMenuDetailFont = @"SanFranciscoText-Light";
static CGFloat kMenuDetailFontSize = 6;

static NSString * kMenuFont = @"HelveticaNeue-Light";
static NSString * kSwipeMenuFont = @"HelveticaNeue-Bold";
static CGFloat kSwipeMenuFontSize = 20;

/*
 *  Animation Keys
 */
static NSString * kShortJumpAnimation = @"shortJumpAnimation";
static NSString * kShortMovementAnimation = @"playerMovementAnimation";

/*
 *  Notification Keys
 */
static NSString * kResetScreenSegmentIndex = @"ResetScreenSegmentIndex";

/*
 *  Segues
 */
static NSString * const kGameSegue = @"GameSegue";
static NSString * const kMenuSegue = @"MenuSegue";

/*
 *  ENUMS
 */

typedef NS_ENUM(NSUInteger, Level) {
                            // Odd value = Indoor Scenes (foreground only)
                            // Even value = Outdoor Scenes (foreground, middleground, and backgrounds)
    ENCOUNTER               = 1,
    GARAGE                  = 3,
    CITY                    = 2,
    JAIL                    = 5,
    BEACH                   = 4,
    SCHOOL                  = 6,
    DESERT                  = 8,
    DEALERSHIP              = 7,
    SHOP                    = 9,
    TOWN                    = 10,
};

typedef NS_ENUM(NSUInteger, Direction) {
    LEFT = 1,
    RIGHT = 2,
    UNKNOWN = 3
};

typedef NS_ENUM(NSUInteger, TravelType) {
    WALKING = 1,
    DRIVING = 2,
    FLYING = 3
};

typedef NS_ENUM(NSUInteger, SceneType) {
    STILL = 1,
    SCROLLABLE = 2,
    FORWARD_SCROLLABLE = 3
};

typedef NS_ENUM(NSUInteger, SegmentType) {
    BACKGROUND = 1,
    MIDDLEGROUND = 2,
    FOREGROUND = 4
};

typedef NS_ENUM(NSUInteger, PlayerState) {
    HEALTHY = 1,
    SICK = 2,
    HURT = 3,
    BADLY_HURT = 4,
    INJURED = 5,
    DEAD = 6
};

typedef NS_ENUM(NSUInteger, ElementType) {
    MONEY = 4,
    DANGER = 6,
    FRIEND = 8,
    ENEMY = 12,
    MYSTERY = 24,
    NONE = 99,
};