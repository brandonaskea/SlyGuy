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

@interface MainMenuViewController () <LaunchViewDelegate>

@property (strong, nonatomic) UIImageView *launchImageView;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLaunchView];
    
    [self setUpUI];
}

-(void)addLaunchView {
    
    self.launchImageView = [[UIImageView alloc] initWithFrame:[GameUtility getLaunchImageRectForScreenSize]];
    self.launchImageView.center = self.view.center;
    [self.view addSubview:self.launchImageView];
    [self.view bringSubviewToFront:self.launchImageView];
    
    LaunchView *launchView = [[LaunchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    launchView.delegate = self;
    [self.view addSubview:launchView];
    [self.view bringSubviewToFront:launchView];
    [launchView configureLaunchView]; // begin animation
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
    
    self.startGameButton.layer.cornerRadius = self.startGameButton.frame.size.height / 2;
    
    self.tutorialButton.layer.cornerRadius = self.startGameButton.frame.size.height / 2;
    
    self.shareButton.layer.cornerRadius = self.startGameButton.frame.size.height / 2;
}

-(void)didDismissLaunchView {
    
    [UIView animateWithDuration:0.45 animations:^{
        self.menuContainerView.alpha = 1;
        self.backgroundImageView.alpha = 1;
        //self.launchImageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 50);
    }];
}

- (IBAction)startGameButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"game" sender:self];
}

- (IBAction)tutorialButtonTapped:(id)sender {
}

- (IBAction)shareButtonTapped:(id)sender {
}
@end
