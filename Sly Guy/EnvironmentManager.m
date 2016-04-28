//
//  EnvironmentManager.m
//  Trumpd
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "EnvironmentManager.h"
#import "GameUtility.h"

@interface EnvironmentManager () {
    
    
}

@property (nonatomic, assign) Level             level;
@property (nonatomic, strong) NSMutableArray    *backgroundTextures;
@property (nonatomic, strong) NSMutableArray    *middlegroundTextures;
@property (nonatomic, strong) NSMutableArray    *foregroundTextures;
@property (nonatomic, assign) CGRect            sceneFrame;

@property (nonatomic, weak)   ScreenSegment     *background1;
@property (nonatomic, weak)   ScreenSegment     *background2;
@property (nonatomic, weak)   ScreenSegment     *middleground1;
@property (nonatomic, weak)   ScreenSegment     *middleground2;
@property (nonatomic, weak)   ScreenSegment     *foreground1;
@property (nonatomic, weak)   ScreenSegment     *foreground2;

@end

@implementation EnvironmentManager

-(id)initWithLevel:(Level)level sceneFrame:(CGRect)sceneFrame {
    self = [super init];
    
    if (self) {
        self.sceneFrame = sceneFrame;
        self.level = level;
        [self setUpEnvironmentSpeeds];
        [self setUpEnvironmentForLevel];
    }
    
    return self;
}

#pragma mark - SET UP

-(void)configureEnvironmentWithBackgroundSegments:(NSArray *)backgroundSegments middlegroundSegments:(NSArray *)middlegroundSegments andForegroundSegments:(NSArray *)foregroundSegments {
    
    // pick out the appropriate dynamic grounds and pair them in this class
    self.background1 = [backgroundSegments objectAtIndex:0];
    self.background2 = [backgroundSegments objectAtIndex:1];
    
    self.middleground1 = [middlegroundSegments objectAtIndex:0];
    self.middleground2 = [middlegroundSegments objectAtIndex:1];
    
    self.foreground1 = [foregroundSegments objectAtIndex:0];
    self.foreground2 = [foregroundSegments objectAtIndex:1];
}

-(void)setUpEnvironmentSpeeds {
    
//    CGFloat backgroundSpeed;
//    CGFloat middlegroundSpeed;
//    CGFloat foregroundSpeed;
//    
//    if (self.travelType == WALKING) {
//        foregroundSpeed = kScrollingBackgroundWalkingSpeed;
//    }
//    else if (self.travelType == DRIVING) {
//        foregroundSpeed = kScrollingBackgroundDrivingSpeed;
//    }
//    else if (self.travelType == FLYING) {
//        foregroundSpeed = kScrollingBackgroundFlyingSpeed;
//    }
//    else {
//        foregroundSpeed = 0;
//    }
    
    self.foregroundSpeed = kScrollingBackgroundWalkingSpeed;
    
    // 2) Reducing the speed of back and middle grounds will give illusion of depth.
    self.middlegroundSpeed = self.foregroundSpeed * 0.5;
    //    backgroundSpeed = middlegroundSpeed * 0.5;
    self.backgroundSpeed = self.middlegroundSpeed * 0.5;
}
-(void)setUpEnvironmentForLevel {
    
    /*
     *  Build the level
     
        1) Set the commonalities. Always 
        start with at the first screen
        segments. Always start at a 0
        offset.
     
        2) Switch through the levels and set 
        each level's different variables and
        style.
     
        3) Build the background segments. By
        setting the totalBackgroundScreenSegments
        the total size of the level is being set.
        The total number of middleground as well
        as foreground screen segments are all
        based on this value.
     
        4) Build the middleground segments.
     */
    
    // 1) Set the commonalities
    // we always start out with a screen segment of 1
    // always start at 0 offset
    self.currentOffset = 0;
    
    
    // 2) Switch through the levels and set each level's different variables and style.
    switch (self.level) {
        case CITY: {
            
            // 3) Build the BACKGROUND segments.
            self.totalBackgroundScreenSegments = kTotalBackgroundSegmentsCity;
            
            self.backgroundTextures = [NSMutableArray new];
            for (int i = 0; i < self.totalBackgroundScreenSegments; i++) {
                
                NSString *randomBackgroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kNumberOfPossibleBackgroundImagesCity + 1);
                
                if (randomNumber==1) {
                    randomBackgroundImage = kCityBackgroundImage1;
                }
                else if (randomNumber==2){
                    randomBackgroundImage = kCityBackgroundImage2;
                }
                else if (randomNumber==3){
                    randomBackgroundImage = kCityBackgroundImage3;
                }
                else if (randomNumber==4){
                    randomBackgroundImage = kCityBackgroundImage4;
                }
                else {
                    randomBackgroundImage = kCityBackgroundImage1;
                }
                
                // this will create a background segment with random characteristcs and add it to the backgroundSegments collection
                [self.backgroundTextures addObject:randomBackgroundImage];
            }
            
//            // 4) Build the MIDDLEGROUND segments.
//            self.totalMiddlegroundScreenSegments = self.totalBackgroundScreenSegments * 3;
//            
//            self.middlegroundSegments = [NSMutableArray new];
//            for (int i = 0; i < self.totalBackgroundScreenSegments; i++) {
//                
//                // this will create a middleground segment with random characteristcs and add it to the middlegroundSegments collection
//                SKTexture *
//                [self.middlegroundSegments addObject:middlegroundSegment];
//            }
//
            // 5) Build the FOREGROUND segments.
            self.totalForegroundScreenSegments = self.totalBackgroundScreenSegments * 5;
            
            self.foregroundTextures = [NSMutableArray new];
            for (int i = 0; i < self.totalForegroundScreenSegments; i++) {
                
                NSString *randomForegroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kNumberOfPossibleForegroundImagesCity + 1);
                
                if (randomNumber==1) {
                    randomForegroundImage = kCityForegroundImage1;
                }
                else if (randomNumber==2){
                    randomForegroundImage = kCityForegroundImage2;
                }
                else if (randomNumber==3){
                    randomForegroundImage = kCityForegroundImage3;
                }
                else if (randomNumber==4){
                    randomForegroundImage = kCityForegroundImage4;
                }
                else {
                    randomForegroundImage = kCityForegroundImage1;
                }
                
                // this will create a foreground segment with random characteristcs and add it to the foregroundSegments collection
                [self.foregroundTextures addObject:randomForegroundImage];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    for (int i = 0; i< self.foregroundTextures.count; i++) {
        NSString *segment = [self.foregroundTextures objectAtIndex:i];
        NSLog(@"%@ %d",segment, i);
    }
}

#pragma mark - UPDATE

-(void)monitorBackgroundForUpdates {
    
    switch (self.scrollingDirection) {
        case LEFT: {
            
            // LEFT
            
            if (self.background1.position.x > self.background1.size.width){
                
                self.currentScreenOffset += 1;
                
                // place it behind background2
                self.background1.position = CGPointMake(self.background2.position.x - self.background2.size.width, self.background1.position.y);
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.background1.index > self.background2.index) {
                    largestDequeuedScreenSegment = (int)self.background1.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                // safty first
                if (nextScreenSegmentToDequeue > self.backgroundTextures.count || nextScreenSegmentToDequeue < 0) {
                    nextScreenSegmentToDequeue = 1;
                }
                
                if (self.background1.index != self.backgroundTextures.count || self.background2.index != self.backgroundTextures.count) {
                    [self.background1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            // 4) same as above but for background2 instead
            if (self.background2.position.x > self.background2.size.width) {
                
                self.currentScreenOffset += 1;
                
                // place it behind background1
                self.background2.position = CGPointMake(self.background1.position.x - self.background1.size.width, self.background2.position.y);
                
                // 5) Update EnvironmentManager
                // This is where we will place the look of each segment
                // In order to do so we must remove the segment we placed on it before
                // Then we will add the new segment it is place.
                
                //            if (self.environmentManager.currentBackgroundScreenSegment < self.environmentManager.totalBackgroundScreenSegments) {
                //                if (self.environmentManager.currentBackgroundScreenSegment == 0) {
                //                    self.environmentManager.currentBackgroundScreenSegment = 1;
                //                }
                //                if (self.environmentManager.currentBackgroundScreenSegment > 0) {
                //                    self.environmentManager.currentBackgroundScreenSegment += 1;
                //                    if (shouldSkipScreenSegmentBackground) {
                //                        self.environmentManager.currentBackgroundScreenSegment += 1;
                //                        shouldSkipScreenSegmentBackground = NO;
                //                    }
                //                }
                //            }
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.background1.index > self.background2.index) {
                    largestDequeuedScreenSegment = (int)self.background1.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                // safty first
                if (nextScreenSegmentToDequeue > self.backgroundTextures.count || nextScreenSegmentToDequeue < 0) {
                    nextScreenSegmentToDequeue = 1;
                }
                
                if (self.background1.index != self.backgroundTextures.count || self.background2.index != self.backgroundTextures.count) {
                    [self.background2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            break;
        }
            
        case RIGHT: {
            
            // RIGHT
            
            if (self.background1.position.x < -self.background1.size.width){
                
                self.currentScreenOffset -= 1;
                
                self.background1.position = CGPointMake(self.background2.position.x + self.background2.size.width, self.background1.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.background1.index < self.background2.index) {
                    smallestDequeuedScreenSegment = (int)self.background1.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                if (self.background1.index != 0 || self.background2.index != 0) {
                    [self.background1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            if (self.background2.position.x < -self.background2.size.width) {
                
                self.currentScreenOffset -= 1;
                
                self.background2.position = CGPointMake(self.background1.position.x + self.background1.size.width, self.background2.position.y);
                
                // 5) Update EnvironmentManager
                // This is where we will place the look of each segment
                // In order to do so we must remove the segment we placed on it before
                // Then we will add the new segment it is place.
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.background1.index < self.background2.index) {
                    smallestDequeuedScreenSegment = (int)self.background1.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                // safty first
                if (nextScreenSegmentToDequeue > self.backgroundTextures.count || nextScreenSegmentToDequeue < 0) {
                    nextScreenSegmentToDequeue = 1;
                }
                if (self.background1.index != 0 || self.background2.index != 0) {
                    [self.background2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            break;
        }
            
        default:
            break;
    }
    
}

-(void)monitorMiddlegroundForUpdates {
    
    switch (self.scrollingDirection) {
        case LEFT: {
            
            // LEFT
            
            if (self.background1.position.x > self.background1.size.width){
                
                // place it behind background2
                self.background1.position = CGPointMake(self.background2.position.x - self.background2.size.width, self.background1.position.y);
                
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.background1.index > self.background2.index) {
                    largestDequeuedScreenSegment = self.background1.index;
                }
                else {
                    largestDequeuedScreenSegment = self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.background1 updateTextureWithOffset:nextScreenSegmentToDequeue];
            }
            
            // 4) same as above but for background2 instead
            if (self.background2.position.x > self.background2.size.width) {
                
                // place it behind background1
                self.background2.position = CGPointMake(self.background1.position.x - self.background1.size.width, self.background2.position.y);
                
                // 5) Update EnvironmentManager
                // This is where we will place the look of each segment
                // In order to do so we must remove the segment we placed on it before
                // Then we will add the new segment it is place.
                
                //            if (self.environmentManager.currentBackgroundScreenSegment < self.environmentManager.totalBackgroundScreenSegments) {
                //                if (self.environmentManager.currentBackgroundScreenSegment == 0) {
                //                    self.environmentManager.currentBackgroundScreenSegment = 1;
                //                }
                //                if (self.environmentManager.currentBackgroundScreenSegment > 0) {
                //                    self.environmentManager.currentBackgroundScreenSegment += 1;
                //                    if (shouldSkipScreenSegmentBackground) {
                //                        self.environmentManager.currentBackgroundScreenSegment += 1;
                //                        shouldSkipScreenSegmentBackground = NO;
                //                    }
                //                }
                //            }
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.background1.index > self.background2.index) {
                    largestDequeuedScreenSegment = self.background1.index;
                }
                else {
                    largestDequeuedScreenSegment = self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.background2 updateTextureWithOffset:nextScreenSegmentToDequeue];
            }
            
            break;
        }
            
        case RIGHT: {
            
            // RIGHT
            
            if (self.background1.position.x < -self.background1.size.width){
                
                self.background1.position = CGPointMake(self.background2.position.x + self.background2.size.width, self.background1.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.background1.index < self.background2.index) {
                    smallestDequeuedScreenSegment = self.background1.index;
                }
                else {
                    smallestDequeuedScreenSegment = self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.background1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                
            }
            
            if (self.background2.position.x < -self.background2.size.width) {
                
                self.background2.position = CGPointMake(self.background1.position.x + self.background1.size.width, self.background2.position.y);
                
                // 5) Update EnvironmentManager
                // This is where we will place the look of each segment
                // In order to do so we must remove the segment we placed on it before
                // Then we will add the new segment it is place.
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.background1.index < self.background2.index) {
                    smallestDequeuedScreenSegment = self.background1.index;
                }
                else {
                    smallestDequeuedScreenSegment = self.background2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.background2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                
            }
            
            break;
        }
            
        default:
            break;
    }
    
}


-(void)monitorForegroundForUpdates {
    
    switch (self.scrollingDirection) {
        case LEFT: {
            
            // LEFT
            
            NSLog(@"FG1 x %f | FG1 w %f | FG2 x %f | FG2 w %f", self.foreground1.position.x, self.foreground1.size.width, self.foreground2.position.x, self.foreground2.size.width);
            
            if (self.foreground1.position.x > self.foreground1.size.width){
                
                self.foreground1.position = CGPointMake(self.foreground2.position.x - self.foreground2.size.width, self.foreground1.position.y);
                
                //            if (self.foreground2.index > self.foreground1.index) {
                //
                //                NSInteger difference = self.foreground2.index - self.foreground1.index;
                //
                //                self.environmentManager.currentForegroundScreenSegment += difference + shouldSkipScreenSegmentForeground;
                //                shouldSkipScreenSegmentForeground = 0;
                //            }
                //            else {
                //                if (self.environmentManager.currentForegroundScreenSegment == 0) {
                //                    self.environmentManager.currentForegroundScreenSegment = 1;
                //                }
                //                else if (self.environmentManager.currentForegroundScreenSegment >= 0) {
                //                    self.environmentManager.currentForegroundScreenSegment += 1;
                //                }
                //            }
                
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.foreground1.index > self.foreground2.index) {
                    largestDequeuedScreenSegment = (int)self.foreground1.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)self.foreground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalForegroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                if (self.foreground1.index != self.foregroundTextures.count || self.foreground2.index != self.foregroundTextures.count) {
                    [self.foreground1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            if (self.foreground2.position.x > self.foreground2.size.width) {
                
                self.foreground2.position = CGPointMake(self.foreground1.position.x - self.foreground1.size.width, self.foreground2.position.y);
                
                
                //            if (self.foreground2.index > self.foreground1.index) {
                //
                //                NSInteger difference = self.foreground2.index - self.foreground1.index;
                //
                //                self.environmentManager.currentForegroundScreenSegment += difference + shouldSkipScreenSegmentForeground;
                //                shouldSkipScreenSegmentForeground = 0;
                //            }
                //            else {
                //                if (self.environmentManager.currentForegroundScreenSegment == 0) {
                //                    self.environmentManager.currentForegroundScreenSegment = 1;
                //                }
                //                else if (self.environmentManager.currentForegroundScreenSegment >= 0) {
                //                    self.environmentManager.currentForegroundScreenSegment += 1;
                //                    if (shouldSkipScreenSegmentForeground) {
                //                        self.environmentManager.currentForegroundScreenSegment += 1;
                //                        shouldSkipScreenSegmentForeground = NO;
                //                    }
                //                }
                //            }
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.foreground1.index > self.foreground2.index) {
                    largestDequeuedScreenSegment = (int)self.foreground1.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)self.foreground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalForegroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                if (self.foreground1.index != self.foregroundTextures.count || self.foreground2.index != self.foregroundTextures.count) {
                    [self.foreground2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
                
            }
            
            break;
        }
            
        case RIGHT: {
            
            // RIGHT
            
            if (self.foreground1.position.x < -self.foreground1.size.width){
                
                self.foreground1.position = CGPointMake(self.foreground2.position.x + self.foreground2.size.width, self.foreground1.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.foreground1.index < self.foreground2.index) {
                    smallestDequeuedScreenSegment = (int)self.foreground1.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)self.foreground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalForegroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                if (self.foreground1.index != 0 || self.foreground2.index != 0) {
                    [self.foreground1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
            }
            
            if (self.foreground2.position.x < -self.foreground2.size.width) {
                
                self.foreground2.position = CGPointMake(self.foreground1.position.x + self.foreground1.size.width, self.foreground2.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.foreground1.index < self.foreground2.index) {
                    smallestDequeuedScreenSegment = (int)self.foreground1.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)self.foreground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalForegroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                if (self.foreground1.index != 0 || self.foreground2.index != 0) {
                    [self.foreground2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                }
            }

            break;
        }
            
        default:
            break;
    }
    
}


-(void)updateCurrentOffsetWithOffset:(NSInteger)offset {
    
    NSInteger offsetToAdd;
    
    switch (self.scrollingDirection) {
        case LEFT:
            
            offsetToAdd = offset;
            
            break;
            
        case RIGHT:
            
            offsetToAdd = -offset;
            
            break;
            
        default:
            break;
    }
    
    NSInteger newOffset = self.currentOffset += offsetToAdd;
    
    if (newOffset == 0) {
        self.currentOffset = 0;
        self.currentScreenOffset = 0;
        //[[NSNotificationCenter defaultCenter] postNotificationName:kResetScreenSegmentIndex object:nil];
    }
}

-(NSString *)placeTextureInSegmentForType:(SegmentType)segmentType atIndex:(NSInteger)index {
    
    /*
     *  This method will return the string
        of the texture name that needs to
        be placed in the Screen Segment.
     */
    NSString *imageNameForTexture;
    
    switch (segmentType) {
            
        case BACKGROUND:
            imageNameForTexture = [self.backgroundTextures objectAtIndex:index];
            break;
            
        case MIDDLEGROUND:
            imageNameForTexture = [self.middlegroundTextures objectAtIndex:index];
            break;
            
        case FOREGROUND:
            imageNameForTexture = [self.foregroundTextures objectAtIndex:index];
            break;
            
        default:
            break;
    }
    
    return imageNameForTexture;
}

@end
