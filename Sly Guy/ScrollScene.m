//
//  ScrollScene.m
//  Trumpd
//
//  Created by Brandon Askea on 4/18/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "ScrollScene.h"
#import "UIColor+GameColors.h"

@implementation ScrollScene

#pragma mark - USER ACTIONS

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
}

#pragma mark - UPDATE METHODS / COLLISION CHECK

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
}

-(BOOL)shouldBeginScrollingInDirection:(Direction)direction {
    
    /*
     *  These are the main calculations that
        are need to be made in order to get
        correct scrolling of the background.
     
        1) Determine where there is enough 
        room left within the level to be able
        to scroll the background.
     
        2) Check whether the Player has moved
        beyond a threshold position that will   
        determine whether or not the background
        should begin scrolling.
     */
    
    if (direction == LEFT) {
    
        if (self.player.position.x <= kPlayerFreezeThreshold && (self.environmentManager.currentScreenOffset + 1) != self.environmentManager.totalBackgroundScreenSegments) {
            return YES;
        }
        else {
            return NO;
        }

    }
    
    else if (direction == RIGHT) {
        
        if (self.sceneType == FORWARD_SCROLLABLE) {
            // Scrolls forward (left) only
            if (self.player.position.x >= (CGRectGetWidth(self.frame) - kPlayerFreezeThreshold) && self.environmentManager.currentOffset == 0) {
                return YES;
            }
            else {
                return NO;
            }
        }
        else if (self.sceneType == SCROLLABLE) {
            // Scrolls forward and backward
            if (self.player.position.x >= (CGRectGetWidth(self.frame) - kPlayerFreezeThreshold) && self.environmentManager.currentOffset != 0) {
                return YES;
            }
            else {
                return NO;
            }
        }
        else {
            return NO;
        }
        
    }
    
    else {
        return NO;
    }
    
}

@end
