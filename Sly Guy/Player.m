//
//  Player.m
//  Sly Guy
//
//  Created by Brandon Askea on 4/28/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "Player.h"

@interface Player () {
    
    
}

@end

@implementation Player

+ (id)sharedPlayer {
    static Player *thePlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:kPlayerDefaults]) {
            thePlayer = [Player playerFromDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:kPlayerDefaults]];
        }
        else {
            thePlayer = [[self alloc] init];
        }
    });
    return thePlayer;
}

- (id)init {
    if (self = [super init]) {
        self.isNew = YES;
        self.health = 1.0;
        self.money = 0;
        self.currentLevel = 1;
        self.car = @"";
    }
    return self;
}



+(Player *)playerFromDictionary:(NSDictionary *)dictionary {
    
    /*
     *  Init the player with persisted defaults
     */
    
    Player *player = [[Player alloc] init];
    player.isNew = NO;
    
    // Health
    NSNumber *healthNumber = (NSNumber *)[dictionary objectForKey:kPlayerDefaultsHealth];
    float health = healthNumber.floatValue;
    player.health = health;
    
    // Money
    NSNumber *moneyNumber = (NSNumber *)[dictionary objectForKey:kPlayerDefaultsMoney];
    NSInteger money = moneyNumber.integerValue;
    player.money = money;
    
    // Level
    NSNumber *levelNumber = (NSNumber *)[dictionary objectForKey:kPlayerDefaultsMoney];
    Level level = levelNumber.integerValue;
    player.currentLevel = level;
    
    // Car
    NSString *car = (NSString *)[dictionary objectForKey:kPlayerDefaultsCar];
    player.car = car;
    
    return player;
}

+(NSDictionary *)convertPlayerIntoDictionary:(Player *)player {
    
    // Get properties
    float health = player.health;
    NSInteger money = player.money;
    NSString *car = player.car;
    Level currentLevel = player.currentLevel;
    
    // Store properties into dictionary
    NSMutableDictionary *playerDic = [NSMutableDictionary new];
    [playerDic setObject:[NSNumber numberWithFloat:health] forKey:kPlayerDefaultsHealth];
    [playerDic setObject:[NSNumber numberWithInteger:money] forKey:kPlayerDefaultsMoney];
    [playerDic setObject:car forKey:kPlayerDefaultsCar];
    [playerDic setObject:[NSNumber numberWithInteger:currentLevel] forKey:kPlayerDefaultsCurrentLevel];
    
    return [NSDictionary dictionaryWithDictionary:playerDic];
}

+(void)savePlayer:(Player *)player {
    
    /*
     *  Save the player to persisted defaults
        Weird because singleton is passed in
        but works because you cannot call 
        self from class method
     */
    
    NSDictionary *playerDefaultsToSave = [Player convertPlayerIntoDictionary:player];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kPlayerDefaults];
    [defaults setObject:playerDefaultsToSave forKey:kPlayerDefaults];
    [defaults synchronize];
}

-(SKSpriteNode *)playerNodeFromPlayer {
    
    SKSpriteNode *playerNode = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(0, 0)];
    playerNode.size = CGSizeMake(kPlayerWidth, kPlayerHeight);
    playerNode.position = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    playerNode.zPosition = 5;
    
    return playerNode;
}

@end
