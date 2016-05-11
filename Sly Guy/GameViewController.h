//
//  GameViewController.h
//  Trumpd
//

//  Copyright (c) 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *callToActionContainer;

@property (strong, nonatomic) IBOutlet UIVisualEffectView *callToActionVisualEffectView;

@property (strong, nonatomic) IBOutlet UIScrollView *callToActionScrollView;

@property (strong, nonatomic) IBOutlet UIView *callToActionSeperator;

@property (strong, nonatomic) IBOutlet UIButton *callToActionButton1;

@property (strong, nonatomic) IBOutlet UIButton *callToActionButton2;

@property (strong, nonatomic) IBOutlet UIButton *callToActionButton3;


@property (nonatomic, assign) Level level;

@end
