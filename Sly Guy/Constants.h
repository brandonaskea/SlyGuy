//
//  Constants.h
//  Trumpd
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
 *  PLAYER SINGLETON CONSTANTS
 */

static NSString * const kPlayerDefaults = @"PlayerDefaults";    // NSDictionary that holds below keys
static NSString * const kPlayerDefaultsHealth = @"PlayerDefaultsHealth";  // NSNumber with float (1.0 = 100%)
static NSString * const kPlayerDefaultsMoney = @"PlayerDefaultsMoney";   // NSNumber with NSInteger (1 = 1 dollar)
static NSString * const kPlayerDefaultsCar = @"PlayerDefaultsCar";       // NSString The Car (if any) the Player owns
static NSString * const kPlayerDefaultsCurrentLevel = @"PlayerDefaultsCurrentLevel"; // The level that the Player is either currently playing, or the one that needs to be loaded

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


static CGFloat kScrollingBackgroundWalkingSpeed = 8.33;
//static CGFloat kScrollingBackgroundWalkingSpeed = 16.17;
static CGFloat kScrollingBackgroundDrivingSpeed = 20;
static CGFloat kScrollingBackgroundFlyingSpeed = 30;

static CGFloat kEnvironmentItemsMinimumSpacing = 30;

// SCREEN SEGMENTS

static NSInteger kTotalBackgroundSegmentsCity = 10;

static NSInteger kTotalBackgroundSegmentsBeach = 10;

static NSInteger kTotalForegroundSegmentsSchool = 40;

static NSString  * const kStrangerEncounterBackgroundImage = @"HomeBackgroundImage";

static NSString  * const kGarageBackgroundImage = @"GarageBackgroundImage";

static u_int32_t kNumberOfPossibleBackgroundImagesCity = 4;
static NSString  * const kCityBackgroundImage1 = @"CityBackgroundImage1";
static NSString  * const kCityBackgroundImage2 = @"CityBackgroundImage2";
static NSString  * const kCityBackgroundImage3 = @"CityBackgroundImage3";
static NSString  * const kCityBackgroundImage4 = @"CityBackgroundImage4";

static u_int32_t kNumberOfPossibleForegroundImagesCity = 4;
static NSString  * const kCityForegroundImage1 = @"CityForegroundImage1-PoleTree";
static NSString  * const kCityForegroundImage2 = @"CityForegroundImage2-OneTree";
static NSString  * const kCityForegroundImage3 = @"CityForegroundImage3-TwoTrees";
static NSString  * const kCityForegroundImage4 = @"CityForegroundImage4-PoleSign";

static u_int32_t kNumberOfPossibleBackgroundImagesBeach = 4;
static NSString  * const kBeachBackgroundImage1 = @"BeachBackgroundImage1";
static NSString  * const kBeachBackgroundImage2 = @"BeachBackgroundImage2";
static NSString  * const kBeachBackgroundImage3 = @"BeachBackgroundImage3";
static NSString  * const kBeachBackgroundImage4 = @"BeachBackgroundImage4";

static u_int32_t kNumberOfPossibleMiddlegroundImagesBeach = 4;
static NSString  * const kBeachMiddlegroundImage1 = @"BeachMiddlegroundImage1";
static NSString  * const kBeachMiddlegroundImage2 = @"BeachMiddlegroundImage2";
static NSString  * const kBeachMiddlegroundImage3 = @"BeachMiddlegroundImage3";
static NSString  * const kBeachMiddlegroundImage4 = @"BeachMiddlegroundImage4";

static u_int32_t kNumberOfPossibleForegroundImagesBeach = 4;
static NSString  * const kBeachForegroundImage1 = @"BeachForegroundImage1";
static NSString  * const kBeachForegroundImage2 = @"BeachForegroundImage2";
static NSString  * const kBeachForegroundImage3 = @"BeachForegroundImage3";
static NSString  * const kBeachForegroundImage4 = @"BeachForegroundImage4";

static u_int32_t kNumberOfPossibleForegroundImagesSchool = 10;
static NSString  * const kSchoolForegroundImage1 = @"SchoolForegroundImage1";
static NSString  * const kSchoolForegroundImage2 = @"SchoolForegroundImage2";
static NSString  * const kSchoolForegroundImage3 = @"SchoolForegroundImage3";
static NSString  * const kSchoolForegroundImage4 = @"SchoolForegroundImage4";
static NSString  * const kSchoolForegroundImage5 = @"SchoolForegroundImage5";
static NSString  * const kSchoolForegroundImage6 = @"SchoolForegroundImage6";
static NSString  * const kSchoolForegroundImage7 = @"SchoolForegroundImage7";
static NSString  * const kSchoolForegroundImage8 = @"SchoolForegroundImage8";
static NSString  * const kSchoolForegroundImage9 = @"SchoolForegroundImage9";
static NSString  * const kSchoolForegroundImage10 = @"SchoolForegroundImage10";

static NSString  * const kGymBackgroundImage1 = @"GymBackgroundImage1";
static NSString  * const kGymBackgroundImage2 = @"GymBackgroundImage2";
static NSString  * const kGymBackgroundImage3 = @"GymBackgroundImage3";
static NSString  * const kGymBackgroundImage4 = @"GymBackgroundImage4";

static NSString  * const kJailBackgroundImage1 = @"JailBackgroundImage1";
static NSString  * const kJailBackgroundImage2 = @"JailBackgroundImage2";
static NSString  * const kJailBackgroundImage3 = @"JailBackgroundImage3";
static NSString  * const kJailBackgroundImage4 = @"JailBackgroundImage4";


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

static CGFloat kSwipeMenuHeaderTrumpQuotePadding = 12;

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
    FOREGROUND = 3
};

typedef NS_ENUM(NSUInteger, PlayerState) {
    HEALTHY = 1,
    SICK = 2,
    HURT = 3,
    BADLY_HURT = 4,
    INJURED = 5,
    DEAD = 6
};