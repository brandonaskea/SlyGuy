//
//  ScreenSegment.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "EnvironmentManager.h"
#import <SpriteKit/SpriteKit.h>

@class EnvironmentManager;

@interface ScreenSegment : SKSpriteNode

@property (nonatomic, assign) Level             level;
@property (nonatomic, assign) SegmentType       segmentType;
@property (nonatomic, assign) BOOL              isEvenSegment;
@property (nonatomic, assign) NSUInteger        index;
@property (nonatomic, assign) Direction         scrollDirection;
@property (nonatomic, strong) SKSpriteNode       *leftEdgeDetector;
@property (nonatomic, strong) SKSpriteNode       *rightEdgeDetector;
@property (nonatomic, strong) EnvironmentManager    *environmentManager;


-(id)initWithSize:(CGSize)size forSegmentType:(SegmentType)segmentType withEnvironmentManager:(EnvironmentManager *)environmentManager;
-(void)updateTextureWithOffset:(NSInteger)offset;
-(void)scrollInDirection:(Direction)direction withTimeSinceLastUpdate:(CFTimeInterval)timeSinceLastUpdate;

@end
