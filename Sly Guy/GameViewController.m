//
//  GameViewController.m
//  Trumpd
//
//  Created by Brandon Askea on 1/24/16.
//  Copyright (c) 2016 Brandon Askea. All rights reserved.
//

#import "GameViewController.h"
#import "TheStillScene.h"
#import "TheScrollScene.h"
#import "SwipeMenu.h"
#import "UIColor+GameColors.h"

@interface GameViewController () <UIGestureRecognizerDelegate, SwipeMenuDelegate> {
    
    BaseScene *scene;
    SKView * skView;
    UIView *swipeView;
    SwipeMenu *swipeMenu;
    UISwipeGestureRecognizer *swipeRight;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    
    [self setUpScene];
    
    [self presentLevel:self.level];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - SETUP METHODS

-(void)setUpScene {
 
    // SETUP SKVIEW
    skView = [[SKView alloc] initWithFrame:self.view.frame];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    // INVISIBLE VIEW FOR SLIDING MENU
    swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSwipeMenuWidth, self.view.bounds.size.height)];
    
    // SWIPE GESTURE
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    
    [swipeView addGestureRecognizer:swipeRight];
    
    [skView addSubview:swipeView];
    [self.view addSubview:skView];
}

-(void)presentLevel:(Level)level {
        
    if (level == 0) {
        level = CITY;
    }
    
    // LOAD THE EPISODE (level)
    if (level % 2 == 0) {
        // Even levels are Scroll Scenes
        scene = [TheScrollScene unarchiveFromFile:@"TheScrollScene"];
    }
    else {
        // Odd levels are Still Scenes
        scene = (TheStillScene *)[TheStillScene unarchiveFromFile:@"TheStillScene"];
    }
    
    // SET UP LEVEL (overload)
    [scene setUpLevel:level];
    
    // SCALE TO FILL THE SCREEN SIZE
    scene.scaleMode = SKSceneScaleModeFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

#pragma mark - SWIPE MENU

-(void)swipeRight {
    
    // PAUSE GAME
    [scene pauseGame];
    
    if (!swipeMenu) {
        
        swipeMenu = [[SwipeMenu alloc] initWithFrame:CGRectMake(-kSwipeMenuWidth, self.view.bounds.size.height / 2, kSwipeMenuWidth, self.view.bounds.size.height)];
        [swipeMenu configureMenuWithFrame:CGRectMake(-kSwipeMenuWidth, self.view.bounds.size.height / 2, kSwipeMenuWidth, self.view.bounds.size.height)];
        swipeMenu.backgroundColor = [UIColor clearColor];
        swipeMenu.delegate = self;
        swipeMenu.center = CGPointMake(-kSwipeMenuWidth, CGRectGetMidY(self.view.frame));
        [self.view addSubview:swipeMenu];
        [self.view bringSubviewToFront:swipeMenu];
        
    }
    
    [UIView animateKeyframesWithDuration:kSwipeAnimationDuration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        
        swipeMenu.center = CGPointMake(kSwipeMenuWidth - (kSwipeMenuWidth / 2), CGRectGetMidY(self.view.frame));
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissMenu {
    
    // MOVE MENU BACK
    [UIView animateKeyframesWithDuration:kSwipeAnimationDuration delay:0.15 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        
        swipeMenu.frame = CGRectMake(-kSwipeMenuWidth, 0, kSwipeMenuWidth, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        // UNPAUSE GAME
        [scene unpauseGame];
        swipeMenu.alpha = 0;
        [swipeMenu removeFromSuperview];
        swipeMenu = nil;
    }];
}

@end
