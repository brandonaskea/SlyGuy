//
//  ElementManager.m
//  Sly Guy
//
//  Created by Brandon Askea on 5/15/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "ElementManager.h"
#import "Element.h"

@interface ElementManager () {
    
}

@property (assign) Level level;
@property (nonatomic, strong) NSCache *elementsCache;

@end

@implementation ElementManager

-(id)initWithLevel:(Level)level {
    
    self = [super init];
    
    if (self) {
        self.level = level;
        self.elementsCache = [[NSCache alloc] init];
    }
    
    return self;
}

#pragma mark - ENVIRONMENT MANAGER DELEGATE
-(void)didRecycleScreenSegment:(ScreenSegment *)screenSegment {
    
    [screenSegment removeAllChildren];
    [self removeElementsForCacheKey:screenSegment.name];
    
    if ([self shouldPlaceElement]) {
        Element *element = [Element spriteNodeWithImageNamed:@"MoneyBag"];
        element.size = CGSizeMake(60, 80);
        element.position = CGPointMake(CGRectGetWidth(screenSegment.frame), CGRectGetMidY(screenSegment.frame));
        element.zPosition = 50;
        element.anchorPoint = CGPointMake(1, 0.5);
        [self.elementsCache setObject:element forKey:[NSString stringWithFormat:@"%@-%@",screenSegment.name, [NSUUID UUID].UUIDString]];
        [screenSegment addChild: element];
        [element emitGlow];
    }
    
}

-(void)removeElementsForCacheKey:(NSString *)cacheKey {
    
}

-(ElementType)elementTypeToPlace {
    
    u_int32_t randomNumber = arc4random_uniform(48 + 1);
    ElementType elementType;
    
    if (randomNumber % MYSTERY == 0) {
        elementType = MYSTERY;
    }
    
    else if (randomNumber % ENEMY == 0) {
        elementType = ENEMY;
    }
    
    else if (randomNumber % FRIEND == 0) {
        elementType = FRIEND;
    }
    
    else if (randomNumber % DANGER == 0) {
        elementType = DANGER;
    }
    
    else if (randomNumber % MONEY == 0) {
        elementType = MONEY;
    }
    
    else {
        elementType = NONE;
    }
    
    return elementType;
}

-(BOOL)shouldPlaceElement {
    
    u_int32_t randomNumber = arc4random_uniform(60 + 1);
    BOOL should = NO;
    
    if ((randomNumber % 2 == 0 && randomNumber % 4 == 0)){
        should = YES;
    }
    return should;
}

@end
