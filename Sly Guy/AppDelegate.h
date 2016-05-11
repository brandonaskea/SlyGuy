//
//  AppDelegate.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/21/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(Player *)getSharedPlayer;

@end

