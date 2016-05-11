//
//  MainMenuViewController.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/27/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) IBOutlet UIView *menuContainerView;

@property (strong, nonatomic) IBOutlet UIButton *startGameButton;
@property (strong, nonatomic) IBOutlet UIButton *tutorialButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;


- (IBAction)startGameButtonTapped:(id)sender;
- (IBAction)tutorialButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;


@end
