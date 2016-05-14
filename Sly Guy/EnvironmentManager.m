//
//  EnvironmentManager.m
//  Trumpd
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "EnvironmentManager.h"
#import "GameUtility.h"
#import "BaseScene.h"

@interface EnvironmentManager () {
    
    
}

@property (nonatomic, strong) NSMutableArray    *backgroundTextures;
@property (nonatomic, strong) NSMutableArray    *middlegroundTextures;
@property (nonatomic, strong) NSMutableArray    *foregroundTextures;
@property (nonatomic, strong) NSCache           *cachedTextures;

@property (nonatomic, weak)   ScreenSegment     *background1;
@property (nonatomic, weak)   ScreenSegment     *background2;
@property (nonatomic, weak)   ScreenSegment     *middleground1;
@property (nonatomic, weak)   ScreenSegment     *middleground2;
@property (nonatomic, weak)   ScreenSegment     *foreground1;
@property (nonatomic, weak)   ScreenSegment     *foreground2;

@property (nonatomic, strong) SKTexture         *nextForegroundTextureToPlace;
@property (nonatomic, strong) SKTexture         *nextBackgroundTextureToPlace;
@property (nonatomic, strong) SKTexture         *nextMiddlegroundTextureToPlace;

@property (nonatomic, weak)   id<EnvironmentManagerDelegate> delegate;

@end

@implementation EnvironmentManager

-(id)initWithLevel:(Level)level {
    self = [super init];
    
    if (self) {
        self.level = level;
        [self setUpEnvironmentSpeeds];
        [self setUpEnvironmentForLevel];
    }
    
    return self;
}

#pragma mark - SET UP

-(void)configureEnvironmentWithBackgroundSegments:(NSArray *)backgroundSegments middlegroundSegments:(NSArray *)middlegroundSegments andForegroundSegments:(NSArray *)foregroundSegments {
    
    // pick out the appropriate dynamic grounds and pair them in this class
    if (backgroundSegments.count > 1) {
        self.background1 = [backgroundSegments objectAtIndex:0];
        self.background2 = [backgroundSegments objectAtIndex:1];
    }
    
    if (middlegroundSegments.count > 1) {
        self.middleground1 = [middlegroundSegments objectAtIndex:0];
        self.middleground2 = [middlegroundSegments objectAtIndex:1];
    }
    
    if (foregroundSegments.count > 1) {
        self.foreground1 = [foregroundSegments objectAtIndex:0];
        self.foreground2 = [foregroundSegments objectAtIndex:1];
    }

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
            
            // LEVEL 1
        case ENCOUNTER: {
            
            self.backgroundTextures = [NSMutableArray new];
            
            // non scrolling environment - place single enviroment background
            
            [self.backgroundTextures addObject:kStrangerEncounterBackgroundImage];
            
            break;
        }
            
        case CITY: {
            
            // 3) Build the BACKGROUND segments.
            self.totalBackgroundScreenSegments = 10;
            
            self.backgroundTextures = [NSMutableArray new];
            for (int i = 0; i < self.totalBackgroundScreenSegments; i++) {
                
                NSString *randomBackgroundImage;
                
                u_int32_t randomIndex = arc4random_uniform(kCityForegroundImages.count - 1);
                
                randomBackgroundImage = [kCityBackgroundImages objectAtIndex:randomIndex];
                
                // this will create a background segment with random characteristcs and add it to the backgroundSegments collection
                [self.backgroundTextures addObject:randomBackgroundImage];
            }
            

            // 4) Build the FOREGROUND segments.
            self.totalMiddlegroundScreenSegments = self.totalBackgroundScreenSegments * 3;
            
            self.middlegroundTextures = [NSMutableArray new];
            for (int i = 0; i < self.totalMiddlegroundScreenSegments; i++) {
                
                NSString *randomMiddlegroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kCityForegroundImages.count - 1);
                
                randomMiddlegroundImage = [kCityForegroundImages objectAtIndex:randomNumber];
                
                // this will create a foreground segment with random characteristcs and add it to the foregroundSegments collection
                [self.middlegroundTextures addObject:randomMiddlegroundImage];
            }

            
            // 5) Build the FOREGROUND segments.
            self.totalForegroundScreenSegments = self.totalBackgroundScreenSegments * 5;
            
            self.foregroundTextures = [NSMutableArray new];
            for (int i = 0; i < self.totalForegroundScreenSegments; i++) {
                
                NSString *randomForegroundImage;
                
                u_int32_t randomIndex = arc4random_uniform(kCityForegroundImages.count - 1);
                
                randomForegroundImage = kCityForegroundImages[randomIndex];
                
                // this will create a foreground segment with random characteristcs and add it to the foregroundSegments collection
                [self.foregroundTextures addObject:randomForegroundImage];
            }
            
            break;
        }
            
        case BEACH: {
            
            self.totalBackgroundScreenSegments = kTotalBackgroundSegmentsBeach * 3;
            self.backgroundTextures = [NSMutableArray new];
            
            for (int i = 0; i < self.totalBackgroundScreenSegments; i++) {
                
                NSString *randomBackgroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kBeachBackgroundImages.count - 1);
                
                randomBackgroundImage = kBeachBackgroundImages[randomNumber];
                
                [self.backgroundTextures addObject:randomBackgroundImage];

            }
            
            self.totalMiddlegroundScreenSegments = kTotalBackgroundSegmentsBeach * 3;
            self.middlegroundTextures = [NSMutableArray new];
            
            for (int i = 0; i < self.totalMiddlegroundScreenSegments; i++) {
                
                NSString *randomMiddlegroundImage;
                
                u_int32_t randomIndex = arc4random_uniform(kBeachMiddlegroundImages.count - 1);
                
                randomMiddlegroundImage = kBeachMiddlegroundImages[randomIndex];
                
                [self.middlegroundTextures addObject:randomMiddlegroundImage];

            }
            
            
            self.totalForegroundScreenSegments = kTotalBackgroundSegmentsBeach * 5;
            self.foregroundTextures = [NSMutableArray new];
            
            for (int i = 0; i < self.totalForegroundScreenSegments; i++) {
                
                NSString *randomForegroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kBeachForegroundImages.count - 1);
                
                randomForegroundImage = kBeachForegroundImages[randomNumber];
                
                [self.foregroundTextures addObject:randomForegroundImage];
                
            }

            
            break;
        }
            
        case SCHOOL: {
            
            self.totalForegroundScreenSegments = kTotalForegroundSegmentsSchool;
            self.foregroundTextures = [NSMutableArray new];
            
            for (int i = 0; i < self.totalForegroundScreenSegments; i++) {
                
                NSString *randomForegroundImage;
                
                u_int32_t randomNumber = arc4random_uniform(kSchoolForegroundImages.count - 1);
                
                randomForegroundImage = kSchoolForegroundImages[randomNumber];
                
                [self.foregroundTextures addObject:randomForegroundImage];
                
            }
            
        }
            
        default:
            break;
    }
    
//    for (int i = 0; i< self.middlegroundTextures.count; i++) {
//        NSString *segment = [self.middlegroundTextures objectAtIndex:i];
//        NSLog(@"%@ %d",segment, i);
//    }
    
    NSMutableArray *texturesToCache = [NSMutableArray new];
    
    // background
    for (NSString* backgroundTextureName in self.backgroundTextures) {
        
        BOOL isNew = YES;
        
        for (NSString *cachedTexture in texturesToCache) {
            
            if ([backgroundTextureName isEqualToString:cachedTexture]) {
                isNew = NO;
            }
        }
        
        if (isNew == YES) {
            [texturesToCache addObject:backgroundTextureName];
        }
    }
    
    // middleground
    for (NSString* middlegroundTextureName in self.middlegroundTextures) {
        
        BOOL isNew = YES;
        
        for (NSString *cachedTexture in texturesToCache) {
            
            if ([middlegroundTextureName isEqualToString:cachedTexture]) {
                isNew = NO;
            }
        }
        
        if (isNew == YES) {
            [texturesToCache addObject:middlegroundTextureName];
        }
    }
    
    // foreground
    for (NSString* foregroundTextureName in self.foregroundTextures) {
        
        BOOL isNew = YES;
        
        for (NSString *cachedTexture in texturesToCache) {
            
            if ([foregroundTextureName isEqualToString:cachedTexture]) {
                isNew = NO;
            }
        }
        
        if (isNew == YES) {
            [texturesToCache addObject:foregroundTextureName];
        }
    }
    
    [self cacheLevelWithTextures:texturesToCache];
}

-(void)cacheLevelWithTextures:(NSArray *)texturesToCache {
    
    self.cachedTextures = [NSCache new];
    
    for (NSString *textureName in texturesToCache) {
        
        SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
        [self.cachedTextures setObject:texture forKey:textureName];
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
            
            if (self.middleground1.position.x > self.middleground1.size.width){
                
                // place it behind background2
                self.middleground1.position = CGPointMake(self.middleground2.position.x - self.middleground2.size.width, self.middleground1.position.y);
                
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.middleground1.index > self.middleground2.index) {
                    largestDequeuedScreenSegment = self.background1.index;
                }
                else {
                    largestDequeuedScreenSegment = self.middleground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.middleground1 updateTextureWithOffset:nextScreenSegmentToDequeue];
            }
            
            // 4) same as above but for background2 instead
            if (self.middleground2.position.x > self.middleground2.size.width) {
                
                // place it behind background1
                self.middleground2.position = CGPointMake(self.middleground1.position.x - self.middleground1.size.width, self.middleground2.position.y);
                
                NSInteger largestDequeuedScreenSegment;
                
                if (self.middleground1.index > self.middleground2.index) {
                    largestDequeuedScreenSegment = self.middleground1.index;
                }
                else {
                    largestDequeuedScreenSegment = self.middleground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = largestDequeuedScreenSegment + 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.middleground2 updateTextureWithOffset:nextScreenSegmentToDequeue];
            }
            
            break;
        }
            
        case RIGHT: {
            
            // RIGHT
            
            if (self.middleground1.position.x < -self.middleground1.size.width){
                
                self.middleground1.position = CGPointMake(self.middleground2.position.x + self.middleground2.size.width, self.middleground1.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.middleground1.index < self.middleground2.index) {
                    smallestDequeuedScreenSegment = self.middleground1.index;
                }
                else {
                    smallestDequeuedScreenSegment = self.middleground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.middleground1 updateTextureWithOffset:nextScreenSegmentToDequeue];
                
            }
            
            if (self.middleground2.position.x < -self.middleground2.size.width) {
                
                self.middleground2.position = CGPointMake(self.middleground1.position.x + self.middleground1.size.width, self.middleground2.position.y);
                
                // 5) Update EnvironmentManager
                // This is where we will place the look of each segment
                // In order to do so we must remove the segment we placed on it before
                // Then we will add the new segment it is place.
                NSInteger smallestDequeuedScreenSegment;
                
                if (self.middleground1.index < self.middleground2.index) {
                    smallestDequeuedScreenSegment = self.middleground1.index;
                }
                else {
                    smallestDequeuedScreenSegment = self.middleground2.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = smallestDequeuedScreenSegment - 1;
                
                // safty first
                //            if (nextScreenSegmentToDequeue > self.environmentManager.totalBackgroundScreenSegments || nextScreenSegmentToDequeue < 0) {
                //                nextScreenSegmentToDequeue = 1;
                //            }
                
                [self.middleground2 updateTextureWithOffset:nextScreenSegmentToDequeue];
                
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
            
            if (self.foreground1.position.x > self.foreground1.size.width){
                
                self.foreground1.position = CGPointMake(self.foreground2.position.x - self.foreground2.size.width, self.foreground1.position.y);
                
                
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

#pragma mark - TEXTURE PLACEMENT

-(SKTexture *)placeTextureInSegmentForType:(SegmentType)segmentType atIndex:(NSInteger)index {
    
    /*
     *  Check if there is a pre-
        loaded texture we can 
        place, if not then get one
        for the index.
     */
    NSString *textureImageName = [self getTextureImageNameForSegment:segmentType atIndex:index];
    
    return [self.cachedTextures objectForKey:textureImageName];
}

-(NSString *)getTextureImageNameForSegment:(SegmentType)segmentType atIndex:(NSInteger)index {
    
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

-(void)prepareNextSegmentsForPlacementWithType:(SegmentType)segmentType atIndex:(NSInteger)index {
    
    NSInteger nextIndex;
    NSInteger maxIndex;
    
    // Find the maximum (total) segments
    switch (segmentType) {
        case BACKGROUND:
            
            maxIndex = self.backgroundTextures.count;
            
            break;
            
        case MIDDLEGROUND:
            
            maxIndex = self.middlegroundTextures.count;
            
            break;
            
        case FOREGROUND:
            
            maxIndex = self.foregroundTextures.count;
            
            break;
            
        default:
            break;
    }
    
    // Determine which index should be next based upon scrolling direction
    if (self.scrollingDirection == LEFT) {
        if (index == maxIndex) {
            nextIndex = index;
        }
        else {
            nextIndex = index + 1;
        }
    }
    else {
        if (index > 0) {
            nextIndex = index - 1;
        }
        else {
            nextIndex = index;
        }
    }
    
    // Store the texture for that index
    switch (segmentType) {
        case BACKGROUND:
            
            self.nextBackgroundTextureToPlace = [SKTexture textureWithImageNamed:[self getTextureImageNameForSegment:BACKGROUND atIndex:nextIndex]];
            
            break;
            
        case MIDDLEGROUND:
            
            self.nextMiddlegroundTextureToPlace = [SKTexture textureWithImageNamed:[self getTextureImageNameForSegment:MIDDLEGROUND atIndex:nextIndex]];
            
            break;
            
        case FOREGROUND:
            
            self.nextForegroundTextureToPlace = [SKTexture textureWithImageNamed:[self getTextureImageNameForSegment:FOREGROUND atIndex:nextIndex]];
            
            break;
            
        default:
            break;
    }
    
}

@end
