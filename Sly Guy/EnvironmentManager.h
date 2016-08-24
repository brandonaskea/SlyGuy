//
//  EnvironmentManager.h
//  Sly Guy
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <SpriteKit/SpriteKit.h>
#import "ScreenSegment.h"
#import "ScreenTexture.h"

@class ScreenSegment;

@protocol EnvironmentManagerDelegate <NSObject>

@required
-(void)didRecycleScreenSegment:(ScreenSegment *)screenSegment;

@end

@interface EnvironmentManager : NSObject

@property (nonatomic, assign) Level             level;
@property (nonatomic, assign) NSInteger currentOffset;
@property (nonatomic, assign) NSInteger currentScreenOffset;
@property (nonatomic, assign) NSInteger largestScreenOffset;
@property (nonatomic, assign) NSInteger smallestScreenOffset;

@property (nonatomic, assign) NSInteger totalBackgroundScreenSegments;
@property (nonatomic, assign) NSInteger totalMiddlegroundScreenSegments;
@property (nonatomic, assign) NSInteger totalForegroundScreenSegments;

@property (nonatomic, assign) CGFloat   backgroundSpeed;
@property (nonatomic, assign) CGFloat   middlegroundSpeed;
@property (nonatomic, assign) CGFloat   foregroundSpeed;

@property (nonatomic, assign) Direction scrollingDirection;

@property (nonatomic, weak)   id<EnvironmentManagerDelegate> delegate;

-(id)initWithLevel:(Level)level;
-(void)updateCurrentOffsetWithOffset:(NSInteger)offset;
-(void)monitorBackgroundForUpdates;
-(void)monitorMiddlegroundForUpdates;
-(void)monitorForegroundForUpdates;
-(void)monitorForUpdatesWithFirstScreenSegement:(ScreenSegment *)firstScreenSegment andSecondScreenSegment:(ScreenSegment *)secondScreenSegment withType:(SegmentType)segmentType ;

-(SKTexture *)placeTextureInSegmentForType:(SegmentType)segmentType atIndex:(NSInteger)index;

@end
