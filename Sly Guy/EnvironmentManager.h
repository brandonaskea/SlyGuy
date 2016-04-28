//
//  EnvironmentManager.h
//  Trumpd
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <SpriteKit/SpriteKit.h>
#import "ScreenSegment.h"

@interface EnvironmentManager : NSObject

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

-(id)initWithLevel:(Level)level sceneFrame:(CGRect)sceneFrame;
-(void)updateCurrentOffsetWithOffset:(NSInteger)offset;
-(void)monitorBackgroundForUpdates;
-(void)monitorMiddlegroundForUpdates;
-(void)monitorForegroundForUpdates;

-(NSString *)placeTextureInSegmentForType:(SegmentType)segmentType atIndex:(NSInteger)index;
-(void)configureEnvironmentWithBackgroundSegments:(NSArray *)backgroundSegments middlegroundSegments:(NSArray *)middlegroundSegments andForegroundSegments:(NSArray *)foregroundSegments;

@end
