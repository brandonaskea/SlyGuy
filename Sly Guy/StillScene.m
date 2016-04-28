//
//  StillScene.m
//  Trumpd
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

-(void)setUpLevel:(Level)level {
    
    /*
     *  Determine which level the user wishes
        to play and build that level. This  
        would include setting the background
        images as well as determining which
        bad guys will come at the player.
     */
    
    switch (level) {
        
        case ENCOUNTER:
            /*
             *  EP. 1) STRANGER ENCOUNTER
                Player is at home unbeknownst of their
                pending journey. They will be encountered
                by a magical stranger who will bestow
                upon them the details of the journey
                they must embark on. Before they leave
                their home, (game) they must find their
                keys, and in so doing pick up as much cash
                as they can before they head out the door.
             */
            self.travelType = WALKING;
            self.sceneType = STILL;
            
            // Add door on the left end of the screen
            
            // Set background images
            
            break;
            
        case GARAGE:
            /*
             *  EP. 2) GARAGE
                Player is introduced to their starting vehical.
                In the garage the player is given a brief
                tutorial on how to drive the car and what to
                expect on the Open Road. Once the player has
                gotten into their car and begins to drive toward
                the left wall, transition to the ATLANTA scene.
             */
            
            break;
            
        default:
            break;
    }
    
    NSLog(@"Set Up STILL Level %lu", (unsigned long)level);
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
