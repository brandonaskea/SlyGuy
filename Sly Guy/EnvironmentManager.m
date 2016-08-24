//
//  EnvironmentManager.m
//  Sly Guy
//
//  Created by Brandon Askea on 4/19/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "EnvironmentManager.h"
#import "GameUtility.h"
#import "BaseScene.h"

@interface EnvironmentManager () <NSCacheDelegate> {
    
    
}

@property (nonatomic, strong) NSMutableArray    *backgroundTextures;
@property (nonatomic, strong) NSMutableArray    *middlegroundTextures;
@property (nonatomic, strong) NSMutableArray    *foregroundTextures;
@property (nonatomic, strong) NSCache           *cachedTextures;

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

//-(void)configureEnvironmentWithBackgroundSegments:(NSArray *)backgroundSegments middlegroundSegments:(NSArray *)middlegroundSegments andForegroundSegments:(NSArray *)foregroundSegments {
//    
//    // pick out the appropriate dynamic grounds and pair them in this class
//    if (backgroundSegments.count > 1) {
//        self.background1 = [backgroundSegments objectAtIndex:0];
//        self.background2 = [backgroundSegments objectAtIndex:1];
//    }
//    
//    if (middlegroundSegments.count > 1) {
//        self.middleground1 = [middlegroundSegments objectAtIndex:0];
//        self.middleground2 = [middlegroundSegments objectAtIndex:1];
//    }
//    
//    if (foregroundSegments.count > 1) {
//        self.foreground1 = [foregroundSegments objectAtIndex:0];
//        self.foreground2 = [foregroundSegments objectAtIndex:1];
//    }
//
//}

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
    
    self.cachedTextures = [[NSCache alloc]init];
    self.cachedTextures.evictsObjectsWithDiscardedContent = NO;
    self.cachedTextures.delegate = self;
    
    for (NSString *textureName in texturesToCache) {
        
        ScreenTexture *texture = [ScreenTexture textureWithImageNamed:textureName];
        texture.name = textureName;
        [self.cachedTextures setObject:texture forKey:textureName];
    }
}

//-(void)cache:(NSCache *)cache willEvictObject:(id)obj {
//    
//    ScreenTexture *evictedTexture = (ScreenTexture *)obj;
//    
//    NSString *evictedTextureName ;
//}

#pragma mark - UPDATE

-(void)monitorForUpdatesWithFirstScreenSegement:(ScreenSegment *)firstScreenSegment andSecondScreenSegment:(ScreenSegment *)secondScreenSegment withType:(SegmentType)segmentType {
    
    NSInteger maximumNumberOfSegments;
    switch (segmentType) {
        case BACKGROUND:
            maximumNumberOfSegments = self.backgroundTextures.count;
            break;
            
        case MIDDLEGROUND:
            maximumNumberOfSegments = self.middlegroundTextures.count;
            break;
            
        case FOREGROUND:
            maximumNumberOfSegments = self.foregroundTextures.count;
            break;
            
        default:
            break;
    }
    
    switch (self.scrollingDirection) {
        case LEFT: {
            
            // LEFT
            
            if (firstScreenSegment.position.x > firstScreenSegment.size.width){
                
                if (segmentType == FOREGROUND) {
                    self.currentScreenOffset += 1;
                }
                
                firstScreenSegment.position = CGPointMake(secondScreenSegment.position.x - secondScreenSegment.size.width, firstScreenSegment.position.y);
                
                
                NSInteger largestDequeuedScreenSegment;
                
                if (firstScreenSegment.index > secondScreenSegment.index) {
                    largestDequeuedScreenSegment = (int)firstScreenSegment.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)secondScreenSegment.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                if (nextScreenSegmentToDequeue <= maximumNumberOfSegments && nextScreenSegmentToDequeue >= 0) {
                    [firstScreenSegment updateTextureWithOffset:nextScreenSegmentToDequeue];
                    if (segmentType == FOREGROUND) {
                        [self.delegate didRecycleScreenSegment:firstScreenSegment];
                    }
                }
                
            }
            
            if (secondScreenSegment.position.x > secondScreenSegment.size.width) {
                
                if (segmentType == FOREGROUND) {
                    self.currentScreenOffset += 1;
                }
                
                secondScreenSegment.position = CGPointMake(firstScreenSegment.position.x - firstScreenSegment.size.width, secondScreenSegment.position.y);
                
                NSInteger largestDequeuedScreenSegment;
                
                if (firstScreenSegment.index > secondScreenSegment.index) {
                    largestDequeuedScreenSegment = (int)firstScreenSegment.index;
                }
                else {
                    largestDequeuedScreenSegment = (int)secondScreenSegment.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)largestDequeuedScreenSegment + 1;
                
                if (nextScreenSegmentToDequeue <= maximumNumberOfSegments && nextScreenSegmentToDequeue >= 0) {
                    [secondScreenSegment updateTextureWithOffset:nextScreenSegmentToDequeue];
                    if (segmentType == FOREGROUND) {
                        [self.delegate didRecycleScreenSegment:secondScreenSegment];
                    }
                }
                
            }
            
            break;
        }
            
        case RIGHT: {
            
            // RIGHT
            
            if (firstScreenSegment.position.x < -firstScreenSegment.size.width){
                
                self.currentScreenOffset -= 1;
                
                firstScreenSegment.position = CGPointMake(secondScreenSegment.position.x + secondScreenSegment.size.width, firstScreenSegment.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (firstScreenSegment.index < secondScreenSegment.index) {
                    smallestDequeuedScreenSegment = (int)firstScreenSegment.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)secondScreenSegment.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                if (nextScreenSegmentToDequeue <= maximumNumberOfSegments && nextScreenSegmentToDequeue >= 0) {
                    [firstScreenSegment updateTextureWithOffset:nextScreenSegmentToDequeue];
                    //                    [self.delegate didRecycleScreenSegment:self.foreground1];
                }
            }
            
            if (secondScreenSegment.position.x < -secondScreenSegment.size.width) {
                
                self.currentScreenOffset -= 1;
                
                secondScreenSegment.position = CGPointMake(firstScreenSegment.position.x + firstScreenSegment.size.width, secondScreenSegment.position.y);
                
                NSInteger smallestDequeuedScreenSegment;
                
                if (firstScreenSegment.index < secondScreenSegment.index) {
                    smallestDequeuedScreenSegment = (int)firstScreenSegment.index;
                }
                else {
                    smallestDequeuedScreenSegment = (int)secondScreenSegment.index;
                }
                
                NSInteger nextScreenSegmentToDequeue = (int)smallestDequeuedScreenSegment - 1;
                
                if (nextScreenSegmentToDequeue <= maximumNumberOfSegments && nextScreenSegmentToDequeue >= 0) {
                    [secondScreenSegment updateTextureWithOffset:nextScreenSegmentToDequeue];
                    //                    [self.delegate didRecycleScreenSegment:self.foreground2];
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
    }
}

#pragma mark - TEXTURE PLACEMENT

-(SKTexture *)placeTextureInSegmentForType:(SegmentType)segmentType atIndex:(NSInteger)index {
    
    /*
     *  Check if there is a cached
        texture loaded that we can
        place, if not then get one
        for the index.
     */
    NSString *textureToPlace = [self getTextureImageNameForSegment:segmentType atIndex:index];
    
    ScreenTexture *cachedTexture = [self.cachedTextures objectForKey:textureToPlace];
    if (cachedTexture) {
        return cachedTexture; // Return from cache, for performace
    }
    
    else {
        return [ScreenTexture textureWithImageNamed:textureToPlace]; // Return by creating new texture
    }
    
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



@end
