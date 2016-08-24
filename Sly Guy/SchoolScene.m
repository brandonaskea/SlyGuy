//
//  SchoolScene.m
//  Sly Guy
//
//  Created by Brandon Askea on 5/9/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "SchoolScene.h"
#import "UIColor+GameColors.h"

@implementation SchoolScene

-(void)setUpLevel {
    
    self.sceneType = FORWARD_SCROLLABLE;
    self.player.zPosition = kPlayerIndoorZPosition;
    SKAction *changeFloorColorAction = [SKAction colorizeWithColor:[SKColor clearColor] colorBlendFactor:1.0 duration:0.01];
    [self.floor runAction:changeFloorColorAction];
    
    // Element Manager
    self.elementManager = [ElementManager new];
    self.environmentManager.delegate = self.elementManager;
}

@end
