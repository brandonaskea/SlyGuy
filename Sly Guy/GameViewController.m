//
//  GameViewController.m
//  Trumpd
//
//  Created by Brandon Askea on 1/24/16.
//  Copyright (c) 2016 Brandon Askea. All rights reserved.
//

#import "GameViewController.h"
#import "HomeScene.h"
#import "CityScene.h"
#import "SchoolScene.h"
#import "BeachScene.h"
#import "SwipeMenu.h"
#import "UIColor+GameColors.h"
#import "AppDelegate.h"

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
    
    [self setUpUI];
    
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

-(void)setUpUI {
 
    // SETUP SKVIEW
    skView = [[SKView alloc] initWithFrame:self.view.frame];
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
    
    // SETUP CALL TO ACTION VIEW
    self.callToActionContainer.backgroundColor = [UIColor clearColor];
    self.callToActionContainer.layer.cornerRadius = kCallToActionContainerCornerRadius;
    self.callToActionContainer.clipsToBounds = YES;
    
    self.callToActionButton1.backgroundColor = [UIColor whiteColor];
    self.callToActionButton1.layer.cornerRadius = kCallToActionButtonCornerRadius;
    [self.callToActionButton1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.callToActionButton2.backgroundColor = [UIColor whiteColor];
    self.callToActionButton2.layer.cornerRadius = kCallToActionButtonCornerRadius;
    [self.callToActionButton2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.callToActionButton3.backgroundColor = [UIColor whiteColor];
    self.callToActionButton3.layer.cornerRadius = kCallToActionButtonCornerRadius;
    [self.callToActionButton3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}

-(void)presentLevel:(Level)level {
        
    switch (level) {
        case ENCOUNTER:
            
            
            
            break;
            
        case GARAGE:
            
            break;
            
        case CITY:
            
            scene = (CityScene *)[CityScene unarchiveFromFile:@"CityScene"];
            
            break;
            
        case SCHOOL:
            
            scene = (SchoolScene *)[SchoolScene unarchiveFromFile:@"SchoolScene"];
            
            break;
            
        case BEACH:
            
            scene = (BeachScene *)[BeachScene unarchiveFromFile:@"BeachScene"];
            
            break;
            
        default:
            break;
    }

    [scene configureLevel:level];
    
    // Present the scene.
    [skView presentScene:scene transition:[SKTransition revealWithDirection:SKTransitionDirectionDown duration:2.0]];
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

-(void)quitGame {
    
    // Breakdown Game
    [scene breakdownGame];
    [skView removeFromSuperview];
    skView = nil;
    [swipeMenu removeFromSuperview];
    swipeMenu = nil;
    [swipeView removeFromSuperview];
    swipeView = nil;
    [swipeRight removeTarget:self action:nil];
    swipeRight = nil;
    
    // Persist player
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Player *sharedPlayer = [appDelegate getSharedPlayer];
    [Player savePlayer:sharedPlayer];
    
    // Segue to Main Menu
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:kMenuSegue sender:self];
    });
    
}

@end
