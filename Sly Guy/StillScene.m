//
//  StillScene.m
//  Sly Guy
//
//  Created by Brandon Askea on 1/29/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "StillScene.h"

@implementation StillScene

#pragma mark - SET UP METHODS

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
}

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

-(BOOL)shouldBeginScrolling {
    
    /*
     *  Because Still Scenes in nature are supposed
        to be not scrolling, return NO.
     */
    
    return NO;
}

@end
