//
//  Element.m
//  Sly Guy
//
//  Created by Brandon Askea on 5/15/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "Element.h"
#import "Constants.h"
#import "UIColor+GameColors.h"

@implementation Element

-(void)removeElementWithAnimation:(BOOL)withAnimation {
    
    /*
     *  withAnimation means the player has 'touched'
        the Element. For example, Money will animate
        it's money particle effect before removate.
     */
    if (withAnimation) {
        
        [self emitParticles];
        
        SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:kElementFadeDuration];
        [self runAction:fadeOut completion:^{
            [self removeFromParent];
        }];
        
    }
    
    else {
        [self removeFromParent];
    }
    
}

-(void)emitGlow {
    
    self.glowColor = [SKColor moneyGlowColor];
    
    SKAction *glowAction = [SKAction colorizeWithColor:self.glowColor colorBlendFactor:0.5 duration:kElementGlowDuration / 2];
    SKAction *unglowAction = [SKAction colorizeWithColor:[SKColor clearColor] colorBlendFactor:0.0 duration:kElementGlowDuration / 2];
    
    SKAction *glow = [SKAction sequence:@[glowAction, unglowAction]];
    SKAction *repeatGlow = [SKAction repeatActionForever:glow];
    
    [self runAction:repeatGlow withKey:kElementRepeatGlowKey];
}

-(void)emitParticles {
    
    // Stop Glowing
    [self removeActionForKey:kElementRepeatGlowKey];
    
    NSString *particlePath = [[NSBundle mainBundle] pathForResource:@"MoneyParticle" ofType:@"sks"];
    SKEmitterNode *particle = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
    particle.position = CGPointMake(-self.frame.size.width/2, 0);
    particle.targetNode = self;
    
    SKAction *fall = [SKAction falloffTo:0 duration:0.25];
    [particle runAction:fall]; //?
    
    // Add Particales | will continue until Element is removed
    [self addChild:particle];
}

@end
