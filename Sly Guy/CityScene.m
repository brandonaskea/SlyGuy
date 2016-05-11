//
//  CityScene.m
//  Sly Guy
//
//  Created by Brandon Askea on 5/10/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "CityScene.h"
#import "UIColor+GameColors.h"

@implementation CityScene

-(void)setUpLevel {
    
    self.sceneType = SCROLLABLE;
    SKAction *changeFloorColorAction = [SKAction colorizeWithColor:[SKColor cityFloorColor] colorBlendFactor:1.0 duration:0.01];
    [self.floor runAction:changeFloorColorAction];
}

@end
