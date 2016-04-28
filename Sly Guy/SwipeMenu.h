//
//  SwipeMenu.h
//  Trumpd
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeMenuDelegate <NSObject>

-(void)dismissMenu;

@end

@interface SwipeMenu : UIView

-(void)configureMenuWithFrame:(CGRect)frame;

@property (weak, nonatomic) id<SwipeMenuDelegate>delegate;

@end