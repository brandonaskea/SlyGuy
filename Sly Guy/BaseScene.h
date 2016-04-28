//
//  BaseScene.h
//  Sly Guy
//
//  Created by Brandon Askea on 1/28/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Constants.h"
#import "EnvironmentManager.h"
#import "ScreenSegment.h"

@interface BaseScene : SKScene

@property (strong, nonatomic) SKSpriteNode *player;

// Gameplay Booleans
@property (nonatomic, assign) Level level;
@property (nonatomic, assign) BOOL isPaused;
@property (nonatomic, assign) BOOL isJumping;
@property (nonatomic, assign) BOOL isTouchingThefloor;
@property (nonatomic, assign) BOOL isMovingLeft;
@property (nonatomic, assign) BOOL isMovingRight;
@property (nonatomic, assign) BOOL isRecentering;
@property (nonatomic, assign) BOOL isScrollingEnabled;
@property (nonatomic, assign) BOOL isPlayerFrozen;
@property (nonatomic, assign) Direction scrollingDirection;
@property (nonatomic, assign) Direction lastScrollingDirection;
@property (nonatomic, assign) TravelType travelType;
@property (nonatomic, assign) SceneType sceneType;
@property (nonatomic, strong) EnvironmentManager *environmentManager;

// Background
@property (nonatomic, strong) ScreenSegment *background1;
@property (nonatomic, strong) ScreenSegment *background2;
@property (nonatomic, strong) ScreenSegment *middleground1;
@property (nonatomic, strong) ScreenSegment *middleground2;
@property (nonatomic, strong) ScreenSegment *foreground1;
@property (nonatomic, strong) ScreenSegment *foreground2;

// Boundaries
@property (strong, nonatomic) SKSpriteNode *leftWall;
@property (strong, nonatomic) SKSpriteNode *rightWall;
@property (strong, nonatomic) SKSpriteNode *floor;

-(void)setUpLevel:(Level)level;
-(BOOL)shouldBeginScrollingInDirection:(Direction)direction;
-(void)pauseGame;
-(void)unpauseGame;

@end
