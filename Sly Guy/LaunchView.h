//
//  LaunchView.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/27/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchViewDelegate <NSObject>

@required
-(void)willDismissLaunchView;
-(void)didDismissLaunchView;

@end

@interface LaunchView : UIView

@property (weak, nonatomic) id<LaunchViewDelegate>delegate;

-(void)configureLaunchView;

@end
