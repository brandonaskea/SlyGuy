//
//  SwipeMenu.h
//  Sly Guy
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeMenuDelegate <NSObject>

-(void)quitGame;
-(void)dismissMenu;

@end

@interface SwipeMenu : UIView

-(void)configureMenuWithFrame:(CGRect)frame;

@property (weak, nonatomic) id<SwipeMenuDelegate>delegate;

@end
