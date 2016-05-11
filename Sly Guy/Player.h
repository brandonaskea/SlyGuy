//
//  Player.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/28/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Constants.h"

@interface Player : NSObject // AKA "User"

@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, assign) BOOL hasLaunchedApp;

@property (nonatomic, assign) Level     currentLevel;
@property (nonatomic, assign) float     health;
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, strong) NSString  *car;

-(SKSpriteNode *)playerNodeFromPlayer;
+ (id)sharedPlayer;
+(void)savePlayer:(Player *)player;

@end
