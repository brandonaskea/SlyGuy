//
//  Element.h
//  Sly Guy
//
//  Created by Brandon Askea on 5/15/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Element : SKSpriteNode

@property (nonatomic, strong) SKColor *glowColor;
@property (nonatomic, strong) SKColor *particleColor;

-(void)emitGlow;
-(void)emitParticles;

@end
