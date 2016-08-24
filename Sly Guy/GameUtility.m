//
//  GameUtility.m
//  Sly Guy
//
//  Created by Brandon Askea on 1/31/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "GameUtility.h"
#import "Constants.h"

@implementation GameUtility

+(NSString *)getMenuTitle {
    
    NSArray *quotes = [NSArray arrayWithObjects:@"Game Paused. Blah Blah Blah ........................................................................", nil];

    
    u_int32_t count = (u_int32_t)quotes.count;
    
    u_int32_t randomIndex = (u_int32_t)arc4random_uniform(count);
    
    return [quotes objectAtIndex:randomIndex];
}

+(NSInteger)getRandomNumberWithCapacity:(NSInteger)capacity {
    
    u_int32_t cap = (uint32_t)capacity;
    
    u_int32_t randomIndex = (u_int32_t)arc4random_uniform(cap);
    
    return (NSInteger)randomIndex;
}

+(NSInteger)getRandomNumberBetween:(NSInteger)one andTwo:(NSInteger)two {
    
    u_int32_t lowerBound = (uint32_t)one;
    u_int32_t upperBound = (uint32_t)two;
    
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    return (NSInteger)rndValue;
}

+(NSInteger)getNumberOfEvenlySpacedItemsWithWidth:(CGFloat)width inEnvironmentLength:(NSInteger)environmentLength withSpacing:(CGFloat)spacing {
    
    NSInteger itemWidth = (NSInteger)width;
    NSInteger minimumSpacing = (NSInteger)spacing;
    
    NSInteger numberOfPossibleItems = environmentLength / (itemWidth + minimumSpacing);
    
    return numberOfPossibleItems;
}

+(NSInteger)getEnvironmentLengthForScreenWidth:(CGFloat)screenWidth totalScreenLengths:(NSInteger)screenLengths {
    
    NSInteger width = (NSInteger)screenWidth;
    
    return width * screenLengths;
}

+(CGRect)getLaunchImageRectForScreenSize:(CGRect)screenSize {
    
    CGRect launchImageRect;
    
    if (IS_IPHONE) {
        
        if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            
            launchImageRect = CGRectMake(0, 0, 250, 250);
        }
        
        else if (IS_IPHONE_6) {
            
            launchImageRect = CGRectMake(0, 0, 250, 250);
        }
        
        else {
            
//            launchImageRect = CGRectMake(0, 0, 170, 560);
            launchImageRect = CGRectMake(CGRectGetMidX(screenSize), CGRectGetMidY(screenSize), 170 - 10, 560);
        }
        
    }
    
    else {
        
        launchImageRect = CGRectMake(0, 0, 250, 250);
    }
    
    return launchImageRect;

}

+(CGFloat)getLaunchImageYOffset {
        
    if (IS_IPHONE) {
        
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            
            return -20;
        }
        
        else if (IS_IPHONE_6) {
            
            return -20;
        }
        
        else {
            
            return -20;
        }
    }
    
    else {
        
        return -20;
    }
}

@end
