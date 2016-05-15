//
//  BeachScene.m
//  Sly Guy
//
//  Created by Brandon Askea on 5/10/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "BeachScene.h"
#import "UIColor+GameColors.h"

@implementation BeachScene

-(void)setUpLevel {
    [super setUpLevel];
    
    self.sceneType = SCROLLABLE;
    SKAction *changeFloorColorAction = [SKAction colorizeWithColor:[SKColor beachSandColorAlternative] colorBlendFactor:1.0 duration:0.01];
    [self.floor runAction:changeFloorColorAction];
}

@end
