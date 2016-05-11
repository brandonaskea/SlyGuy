//
//  ScreenSegment.m
//  Trumpd
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "ScreenSegment.h"
#import "GameUtility.h"

@interface ScreenSegment () {
    
}

//@property (nonatomic, strong) EnvironmentManager    *environmentManager;
//@property (nonatomic, strong) NSTimer               *shouldUpdateTextureTimer;
@property (nonatomic, assign) BOOL                  shouldUpdateTexture;

@end

@implementation ScreenSegment

-(id)initWithSize:(CGSize)size forSegmentType:(SegmentType)segmentType withEnvironmentManager:(EnvironmentManager *)environmentManager {
    
    self = [super init];
    
    if (self) {
        self.size = size;
        self.segmentType = segmentType;
        self.environmentManager = environmentManager;
        self.shouldUpdateTexture = YES;
        [self registerForNotifications];
     }
    
    return self;
}

-(void)dealloc {
    
//    [self.shouldUpdateTextureTimer invalidate];
//    self.shouldUpdateTextureTimer = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kResetScreenSegmentIndex object:nil];
}

-(void)updateTextureWithOffset:(NSInteger)offset {
    
//    if (self.shouldUpdateTexture) {
//        self.shouldUpdateTexture = NO;
//        self.index = offset;
//        [self setTexture:[self.environmentManager placeTextureInSegmentForType:self.segmentType atIndex:self.index]];
//        [self fireShouldUpdateTextureTimer];
//    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.index = offset;
        [self setTexture:[self.environmentManager placeTextureInSegmentForType:self.segmentType atIndex:self.index]];
    });
    
}

//-(void)fireShouldUpdateTextureTimer {
//    
//    self.shouldUpdateTextureTimer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(invalidateShouldUpdateTextureTimer) userInfo:nil repeats:NO];
//}

//-(void)invalidateShouldUpdateTextureTimer {
//    self.shouldUpdateTexture = YES;
//    [self.shouldUpdateTextureTimer invalidate];
//    self.shouldUpdateTextureTimer = nil;
//}

-(void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetIndexToZero:) name:kResetScreenSegmentIndex object:nil];
}

-(void)resetIndexToZero:(NSNotification *)notification {
    
    self.index = 0;
}

-(void)scrollInDirection:(Direction)direction {
    
    CGFloat speed;
    switch (self.segmentType) {
            
        case BACKGROUND:
            speed = self.environmentManager.backgroundSpeed;
            break;
            
        case MIDDLEGROUND:
            speed = self.environmentManager.middlegroundSpeed;
            break;
            
        case FOREGROUND:
            speed = self.environmentManager.foregroundSpeed;
            break;
            
        default:
            break;
    }
    
    if (direction == LEFT) {
        self.position = CGPointMake(self.position.x+speed, self.position.y);
    }
    
    else if (direction == RIGHT) {
        self.position = CGPointMake(self.position.x-speed, self.position.y);
    }
    
    else {
       // nothing
    }
    
}

@end
