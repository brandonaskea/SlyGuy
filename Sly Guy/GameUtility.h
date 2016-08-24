//
//  GameUtility.h
//  Sly Guy
//
//  Created by Brandon Askea on 1/31/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameUtility : NSObject

+(NSString *)getMenuTitle;
+(NSInteger)getRandomNumberWithCapacity:(NSInteger)capacity;
+(NSInteger)getRandomNumberBetween:(NSInteger)one andTwo:(NSInteger)two;
+(NSInteger)getNumberOfEvenlySpacedItemsWithWidth:(CGFloat)width inEnvironmentLength:(NSInteger)environmentLength withSpacing:(CGFloat)spacing;
+(NSInteger)getEnvironmentLengthForScreenWidth:(CGFloat)screenWidth totalScreenLengths:(NSInteger)screenLengths;
+(CGRect)getLaunchImageRectForScreenSize:(CGRect)screenSize;
+(CGFloat)getLaunchImageYOffset;
@end
