//
//  MainMenuViewController.m
//  Sly Guy
//
//  Created by Brandon Askea on 4/27/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Constants.h"
#import "GameUtility.h"
#import "LaunchView.h"
#import "Player.h"
#import "AppDelegate.h"
#import "GameViewController.h"

@interface MainMenuViewController () <LaunchViewDelegate> {
    
    Player *sharedPlayer;
    LaunchView *launchView;
}

@property (strong, nonatomic) UIImageView *launchImageView;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPlayer];
    
    if (!sharedPlayer.hasLaunchedApp) {
        [self addLaunchView];
    }
    
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated {
    
    if (sharedPlayer.hasLaunchedApp) {
        [self presentMainMenu];
    }
}

#pragma mark - SET UP METHODS

-(void)setUpPlayer {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    sharedPlayer = [appDelegate getSharedPlayer];
}

-(void)addLaunchView {
    
    launchView = [[LaunchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    launchView.delegate = self;
    [self.view addSubview:launchView];
    [self.view bringSubviewToFront:launchView];
    [launchView configureLaunchView]; // begin animation
    
    self.launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 200)];
    self.launchImageView.center = self.view.center;
    self.launchImageView.image = [UIImage imageNamed:@"LogoTempLaunch"];
    [self.launchImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:self.launchImageView];
    [self.view bringSubviewToFront:self.launchImageView];
    
    CGRect bounceDownFrame = CGRectMake(0, 0, self.launchImageView.frame.size.width * 0.80, self.launchImageView.frame.size.height * 0.82);
    CGRect bounceUpFrame = [GameUtility getLaunchImageRectForScreenSize:[UIScreen mainScreen].bounds];
    
    // Bounce Down
    [UIView animateWithDuration:0.25 delay:1.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.launchImageView.frame = bounceDownFrame;
        self.launchImageView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            // Bounce Up
            [UIView animateWithDuration:1.0 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.launchImageView.frame = bounceUpFrame;
                self.launchImageView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds)+[GameUtility getLaunchImageYOffset]);
                self.launchImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                
            } completion:^(BOOL finished) {
                
                if (finished) {

                    [UIView animateWithDuration:0.35 animations:^{
                        
                        launchView.alpha = 0;
                        self.menuContainerView.alpha = 1;
                        self.backgroundImageView.alpha = 1;
                        [self.launchImageView setCenter:CGPointMake(self.launchImageView.center.x, (self.launchImageView.frame.size.height / 2) + kLaunchImageTopPadding)];
                        
                    } completion:^(BOOL finished) {
                        
                        if (finished) {
                            
                            [UIView animateWithDuration:0.30 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                
                                launchView.alpha = 0;
                                self.menuContainerView.alpha = 1;
                                self.backgroundImageView.alpha = 1;
                                
                            } completion:^(BOOL finished) {
                                
                                if (finished) {
                                    [launchView removeFromSuperview];
                                    sharedPlayer.hasLaunchedApp = YES;
                                }
                            }];
                        }
                        
                    }];
                    
                }
                
            }];
            
        }
        
    }];
    
}

-(void)setUpUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.backgroundImageView.alpha = 0;
    
    // MENU
    [self setUpMenu];
}

-(void)setUpMenu {
    
    self.menuContainerView.alpha = 0;
    self.menuContainerView.layer.cornerRadius = kMenuContainerCornerRadius;
    
    // Start Button
    self.startGameButton.layer.cornerRadius = self.startGameButton.frame.size.height / 2;
    if (sharedPlayer.isNew) {
        [self.startGameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
    }
    else {
        [self.startGameButton setTitle:@"Continue Game" forState:UIControlStateNormal];
    }
    
    self.tutorialButton.layer.cornerRadius = self.tutorialButton.frame.size.height / 2;
    
    self.shareButton.layer.cornerRadius = self.shareButton.frame.size.height / 2;
}

-(void)presentMainMenu {
    
//    // Add logo
//    if (!self.launchImageView) {
//        self.launchImageView = [[UIImageView alloc] initWithFrame:[GameUtility getLaunchImageRectForScreenSize:[UIScreen mainScreen].bounds]];
//        self.launchImageView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds)+[GameUtility getLaunchImageYOffset]);
//        self.launchImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//        self.launchImageView.alpha = 0;
//        [self.view addSubview:self.launchImageView];
//        [self.view bringSubviewToFront:self.launchImageView];
//    }
    
    self.launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 200)];
    self.launchImageView.center = self.view.center;
    self.launchImageView.image = [UIImage imageNamed:@"LogoTempLaunch"];
    [self.launchImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.launchImageView.alpha = 0;
    [self.view addSubview:self.launchImageView];
    [self.view bringSubviewToFront:self.launchImageView];
    
    CGRect bounceDownFrame = CGRectMake(0, 0, self.launchImageView.frame.size.width * 0.80, self.launchImageView.frame.size.height * 0.82);
    CGRect bounceUpFrame = [GameUtility getLaunchImageRectForScreenSize:[UIScreen mainScreen].bounds];
    
    // Bounce Down
    [UIView animateWithDuration:0.01 delay:0.01 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.launchImageView.frame = bounceDownFrame;
        self.launchImageView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            // Bounce Up
            [UIView animateWithDuration:0.01 delay:0.01 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.launchImageView.frame = bounceUpFrame;
                self.launchImageView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds)+[GameUtility getLaunchImageYOffset]);
                self.launchImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                    [UIView animateWithDuration:0.01 animations:^{
                        
                        self.launchImageView.alpha = 1;
                        self.menuContainerView.alpha = 1;
                        self.backgroundImageView.alpha = 1;
                        [self.launchImageView setCenter:CGPointMake(self.launchImageView.center.x, (self.launchImageView.frame.size.height / 2) + kLaunchImageTopPadding)];
                        
                    } completion:^(BOOL finished) {
                        
                        if (finished) {
                            
                            [UIView animateWithDuration:0.01 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                
                                self.menuContainerView.alpha = 1;
                                self.backgroundImageView.alpha = 1;
                                
                            } completion:^(BOOL finished) {
                                
                            }];
                        }
                        
                    }];
                    
                }
                
            }];
            
        }
        
    }];

}

#pragma mark - BUTTON ACTIONS

- (IBAction)startGameButtonTapped:(id)sender {
    
    if (sharedPlayer.isNew) {
        // Run onboarding sequence
        [self performSegueWithIdentifier:kGameSegue sender:self];
    }
    else {
        [self performSegueWithIdentifier:kGameSegue sender:self];
    }
}

- (IBAction)tutorialButtonTapped:(id)sender {
}

- (IBAction)shareButtonTapped:(id)sender {
}

#pragma mark - SEGUE

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kGameSegue]) {
        
        GameViewController *gameVC = (GameViewController *)segue.destinationViewController;
        gameVC.level = BEACH;
    }
}
@end
