//
//  LaunchView.m
//  Sly Guy
//
//  Created by Brandon Askea on 4/27/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "LaunchView.h"
#import "GameUtility.h"

@implementation LaunchView

-(void)configureLaunchView {
    
    
    /*
     *  DYNAMIC LAUNCH IMAGE
        
        1) Set the background color to be
        the same as the launch screen.
        
        2) Add the launch image to the 
        launch view in the same dimentions
        as the launch screen, so when it
        animates, it appears to be on the
        same screen.
     
        3) Animate the image to 'bounce'.
     
        4) The image's bounce will increase
        the image frame to be equal to the
        background image of the menu. Once
        the animation is complete the launch
        view itself will then fade out to 
        leave the background image onscreen.
     */
    
    
    // 1) Set background color
    self.backgroundColor = [UIColor whiteColor];
    
    // 2) Add the launch image
//    UIImageView *launchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 200)];
//    launchImage.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    launchImage.image = [UIImage imageNamed:@"LogoTempLaunch"];
//    [launchImage setContentMode:UIViewContentModeScaleAspectFill];
//    [self addSubview:launchImage];
    
    // 3) Animate the image to 'bounce'.
    
//    CGRect bounceDownFrame = CGRectMake(0, 0, launchImage.frame.size.width * 0.5, launchImage.frame.size.height * 0.5);
//    CGRect bounceUpFrame = [GameUtility getLaunchImageRectForScreenSize:[UIScreen mainScreen].bounds];
//    
//    // Bounce Down
//    [UIView animateWithDuration:0.25 delay:1.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        launchImage.frame = bounceDownFrame;
//        launchImage.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//        
//    } completion:^(BOOL finished) {
//        
//        if (finished) {
//            
//            // Bounce Up
//            [UIView animateWithDuration:0.80 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                
//                launchImage.frame = bounceUpFrame;
//                launchImage.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+[GameUtility getLaunchImageYOffset]);
//                launchImage.transform = CGAffineTransformMakeRotation(M_PI_2);
//                
//            } completion:^(BOOL finished) {
//                
//                if (finished) {
//                    // fade out
//                    [self.delegate willDismissLaunchView];
//                    [UIView animateWithDuration:0.20 animations:^{
//                        
//                        self.alpha = 0;
//                        
//                    } completion:^(BOOL finished) {
//                        
//                        if (finished) {
//                            
//                            [self removeFromSuperview];
//                            [self.delegate didDismissLaunchView];
//                        }
//                    }];
//                    
//                }
//                
//            }];
//            
//        }
//        
//    }];
}

@end
