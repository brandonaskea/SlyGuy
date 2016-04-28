//
//  BaseScene.m
//  Sly Guy
//
//  Created by Brandon Askea on 1/28/16.
//  Copyright © 2016 Brandon Askea. All rights reserved.
//

#import "BaseScene.h"
#import "Constants.h"
#import "UIColor+GameColors.h"

@interface BaseScene () <UIGestureRecognizerDelegate> {
    
    // CONTROLS
    SKLabelNode                     *scoreLabel;
    SKSpriteNode                    *moveLeftButton;
    SKSpriteNode                    *moveRightButton;
    UITapGestureRecognizer          *jumpGesture;
    SKPhysicsBody                   *physicsBody;
    NSTimer                         *touchesTimer;
    SKSpriteNode                    *healthImage;
    SKLabelNode                     *healthLabel;
    SKSpriteNode                    *moneyImage;
    SKLabelNode                     *moneyLabel;
    UILongPressGestureRecognizer    *longPress;
    
    BOOL                            shouldSkipScreenSegmentBackground;
    BOOL                            shouldSkipScreenSegmentMiddleground;
    BOOL                            shouldSkipScreenSegmentForeground;
}

@property (nonatomic, assign) BOOL didScroll;

@end

@implementation BaseScene

#pragma mark - SET UP METHODS

-(void)didMoveToView:(SKView *)view {
    
    /*
     *  SET UP BASIC GAME
        This will impose the basic rules,
        gestures and scene settings for
        the all of the similarities that    
        will exist between the levels
        (or scenes) that the user might  
        choose to play.
     */
    [self setUpBaseScene];
    
    /*
     *  SET UP ENVIRONMENT
        Here the scrolling Screen Segments
        will be created and initialized
        with their beginning textures.
     */
    [self setUpEnvironment];
    
    /*
     *  ADD ON SCREEN CONTROLS
        A "left" and "right" button to move 
        the player around the screen. This
        will also place a score button in 
        the middle between both buttons.
     */
    [self addControls];
    
    
    /*
     *  PLACE BOUNDARIES
        The player will fall off the screen
        if we do not set parameters in which 
        they will exist. The will place invisible
        walls at the edge of the screen and a 
        floor beneath the player that will keep 
        them from falling through the level.
     */
    [self placeBoundaries];
    
    
    /*
     *  SET UP PLAYER
        This will add the player to the game
        and set it's initial physics body.
     */
    [self setThePlayer];
    
}

-(void)setUpLevel:(Level)level {
    
    // This should be overloaded
}

-(void)setUpBaseScene {
    
    self.backgroundColor = [SKColor whiteColor];

    self.isScrollingEnabled = YES;
    self.isJumping = NO;
    self.isPaused = NO;
    shouldSkipScreenSegmentBackground = NO;
    shouldSkipScreenSegmentMiddleground = NO;
    shouldSkipScreenSegmentForeground = NO;
    
    jumpGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(jump)];
    jumpGesture.delaysTouchesBegan = NO;
    jumpGesture.delegate = self;
    
    // Light
    SKLightNode *light = [[SKLightNode alloc] init];
    light.lightColor = [SKColor greenColor];
    light.ambientColor = [SKColor darkGrayColor];
    light.position = CGPointMake(CGRectGetWidth(self.frame), 0);
    [self addChild:light];
}

-(void)setUpEnvironment {
    
    /*
     *  Set Up Environment
     
     1) Set up EnvironmentManager. This will
     keep track of what Screen Segments to be
     placed on dynamic grounds.
     
     2) Set up dynamic 'grounds'. This includes
     background, middleground, and foreground.
     
     Whether the scene is that of scrolling type
     or not, the environment manager will always
     place the first Screen Segment.
     */
    
    // 1) Set up EnvironmentManager.
    if (!self.environmentManager) {
        self.environmentManager = [[EnvironmentManager alloc] initWithLevel:self.level sceneFrame:self.frame];
    }
    
    
    // 2) Set up dynamic 'grounds'.
    NSArray* backgrounds;
    NSArray* middlegrounds;
    NSArray* foregrounds;
    
    self.background1 = [[ScreenSegment alloc] initWithSize:CGSizeMake(CGRectGetWidth(self.frame) + 2, CGRectGetHeight(self.frame)) forSegmentType:BACKGROUND withEnvironmentManager:self.environmentManager];
    self.background1.size = CGSizeMake(CGRectGetWidth(self.frame) + 2, CGRectGetHeight(self.frame));
    self.background1.anchorPoint = CGPointZero;
    self.background1.position = CGPointMake(0, 0);
    self.background1.zPosition = BACKGROUND;
    [self addChild:self.background1];
    
    self.background2 = [[ScreenSegment alloc] initWithSize:CGSizeMake(CGRectGetWidth(self.frame) + 2, CGRectGetHeight(self.frame)) forSegmentType:BACKGROUND withEnvironmentManager:self.environmentManager];
    self.background2.size = CGSizeMake(CGRectGetWidth(self.frame) + 2, CGRectGetHeight(self.frame));
    self.background2.anchorPoint = CGPointZero;
    self.background2.position = CGPointMake(self.background1.size.width-1, 0);
    self.background2.zPosition = BACKGROUND;
    [self addChild:self.background2];
    
    backgrounds = [NSArray arrayWithObjects:self.background1, self.background2, nil];
    
    //    self.middleground1 = [SKSpriteNode spriteNodeWithImageNamed:@"clouds"];
    //    self.middleground1.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2);
    //    self.middleground1.anchorPoint = CGPointZero;
    //    self.middleground1.position = CGPointMake(0, 0);
    //    self.middleground1.zPosition = 0;
    //    [self addChild:self.middleground1];
    //
    //    self.middleground2 = [SKSpriteNode spriteNodeWithImageNamed:@"clouds"];
    //    self.middleground2.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2);
    //    self.middleground2.anchorPoint = CGPointZero;
    //    self.middleground2.position = CGPointMake(self.middleground1.size.width-1, 0);
    //    self.middleground2.zPosition = 0;
    //    [self addChild:self.middleground2];
    //
    self.foreground1 = [[ScreenSegment alloc] initWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) forSegmentType:FOREGROUND withEnvironmentManager:self.environmentManager];
    self.foreground1.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.foreground1.anchorPoint = CGPointZero;
    self.foreground1.position = CGPointMake(0, 0);
    self.foreground1.zPosition = FOREGROUND;
    [self addChild:self.foreground1];
    
    self.foreground2 = [[ScreenSegment alloc] initWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) forSegmentType:FOREGROUND withEnvironmentManager:self.environmentManager];
    self.foreground2.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.foreground2.anchorPoint = CGPointZero;
    self.foreground2.position = CGPointMake(self.foreground1.size.width-1, 0);
    self.foreground2.zPosition = FOREGROUND;
    [self addChild:self.foreground2];
    
    foregrounds = [NSArray arrayWithObjects:self.foreground1, self.foreground2, nil];
    
    [self.environmentManager configureEnvironmentWithBackgroundSegments:backgrounds middlegroundSegments:middlegrounds andForegroundSegments:foregrounds];
    
    // Whether the scene is that of scrolling type or not, the environment manager will always place the first Screen Segment.
    [self.background1 updateTextureWithOffset:0];
    
    if (self.level % 2 == 0) {
        // If scene is of scroll type, set initial middleground and foreground.
        
        //[self.middleground1 setTexture:[self.environmentManager placeTextureInSegmentForType:MIDDLEGROUND atIndex:0]];
        
        [self.foreground1 updateTextureWithOffset:0];
    }
}

-(void)addControls {
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
    scoreLabel.fontSize = 20;
    scoreLabel.fontColor = [SKColor darkGrayColor];
    scoreLabel.text = @"Score: 0";
    scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) - (kScoreLabelHeight + kScoreLabelPadding));
    scoreLabel.zPosition = 5;
    [self addChild:scoreLabel];
    
    // Left Button
    moveLeftButton = [SKSpriteNode spriteNodeWithImageNamed:@"LeftArrow"];
    moveRightButton.size = CGSizeMake(kMoveLeftButtonWidth, kMoveLeftButtonHeight);
    moveLeftButton.anchorPoint = CGPointMake(0, 1);
    moveLeftButton.position = CGPointMake(kMoveButtonPadding, CGRectGetHeight(self.frame) - kMoveButtonPadding);
    moveLeftButton.zPosition = 5;
    [self addChild:moveLeftButton];
    
    // Right Button
    moveRightButton = [SKSpriteNode spriteNodeWithImageNamed:@"RightArrow"];
    moveRightButton.size = CGSizeMake(kMoveLeftButtonWidth, kMoveLeftButtonHeight);
    moveRightButton.anchorPoint = CGPointMake(1, 1);
    moveRightButton.position = CGPointMake(CGRectGetWidth(self.frame) - kMoveButtonPadding, CGRectGetHeight(self.frame) - kMoveButtonPadding);
    moveRightButton.zPosition = 5;
    [self addChild:moveRightButton];
    
    // Health Image
    healthImage = [SKSpriteNode spriteNodeWithImageNamed:@"Heart"];
    healthImage.size = CGSizeMake(kHealthImageHW, kHealthImageHW);
    healthImage.anchorPoint = CGPointMake(0, 1);
    healthImage.position = CGPointMake(CGRectGetWidth(moveLeftButton.frame) + (kMoveButtonPadding * 2), CGRectGetHeight(self.frame) - (scoreLabel.frame.size.height + kMoveButtonPadding + kHealthImageTopPadding));
    healthImage.zPosition = 5;
    [self addChild:healthImage];
    
    // Health Label
    healthLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
    healthLabel.fontSize = kHealthLabelFontSize;
    healthLabel.fontColor = [SKColor redColor];
    healthLabel.text = @"100%";
    healthLabel.position = CGPointMake(CGRectGetWidth(moveLeftButton.frame) + CGRectGetWidth(healthImage.frame) + (kMoveButtonPadding * 2) + kHealthLabelPadding, CGRectGetHeight(self.frame) - (scoreLabel.frame.size.height + kMoveButtonPadding + kHealthImageTopPadding + kHealthLabelTopPadding));
    healthLabel.zPosition = 5;
    [self addChild:healthLabel];
    
    // Money Image
    moneyImage = [SKSpriteNode spriteNodeWithImageNamed:@"MoneyBag"];
    moneyImage.size = CGSizeMake(kMoneyImageHW, kMoneyImageHW);
    moneyImage.anchorPoint = CGPointMake(1, 1);
    moneyImage.position = CGPointMake(CGRectGetWidth(self.frame) - ((CGRectGetWidth(moveRightButton.frame)) + (kMoveButtonPadding * 2)), CGRectGetHeight(self.frame) - (scoreLabel.frame.size.height + kMoveButtonPadding + kMoneyImageTopPadding));
    moneyImage.zPosition = 5;
    [self addChild:moneyImage];
    
    // Money Label
    moneyLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
    moneyLabel.fontSize = kHealthLabelFontSize;
    moneyLabel.fontColor = [SKColor greenColor];
    moneyLabel.text = @"$100";
    moneyLabel.position = CGPointMake(CGRectGetWidth(self.frame) - (CGRectGetWidth(moneyImage.frame) + CGRectGetWidth(moveRightButton.frame) + (kMoveButtonPadding * 2) + kMoneyLabelPadding), CGRectGetHeight(self.frame) - (scoreLabel.frame.size.height + kMoveButtonPadding + kHealthImageTopPadding + kHealthLabelTopPadding));
    moneyLabel.zPosition = 5;
    [self addChild:moneyLabel];
    
}

-(void)placeBoundaries {
    
    self.floor = [SKSpriteNode spriteNodeWithColor:[UIColor cityFloorColor] size:CGSizeMake(CGRectGetWidth(self.frame), 20)];
    self.floor.anchorPoint = CGPointMake(0, 0);
    self.floor.position = CGPointMake(0, 0);
    self.floor.zPosition = 5;
    [self addChild:self.floor];
    
    // Left Wall
    self.leftWall = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(kWallWidth, CGRectGetHeight(self.frame))];
    self.leftWall.anchorPoint = CGPointMake(0, 0);
    self.leftWall.position = CGPointMake(0, 0);
    self.leftWall.zPosition = 5;
    [self addChild:self.leftWall];
    
    // Right Wall
    self.rightWall = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(kWallWidth, CGRectGetHeight(self.frame))];
    self.rightWall.anchorPoint = CGPointMake(1, 0);
    self.rightWall.position = CGPointMake(CGRectGetWidth(self.frame), 0);
    self.rightWall.zPosition = 5;
    [self addChild:self.rightWall];
}

-(void)setThePlayer {
    
    // Set up the player node
    self.player = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(0, 0)];
    self.player.size = CGSizeMake(kPlayerWidth, kPlayerHeight);
    self.player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.player.zPosition = 5;
    
    // add physics to player
    physicsBody = [SKPhysicsBody bodyWithBodies:@[]];
    physicsBody.affectedByGravity = YES;
    physicsBody.charge = 0.5;
    physicsBody.dynamic = YES;
    physicsBody.restitution = 0.5;
    physicsBody.angularDamping = 15;
    self.player.physicsBody = physicsBody;
    [self addChild:self.player];
    
}

#pragma mark - USER ACTIONS

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /*
     *  TOUCHES | This will detect the user interaction
        with the controls.
        
        1) Get the touch
        2) Detect Pressing Left Button
        3) Detect Pressing Right Button
        4) If not touching the move buttons, then jump
     */
    
    if (self.isRecentering == NO && self.isTouchingThefloor == YES) {
        
        for (UITouch *touch in touches) {
            
            // 1) Get the touch
            CGPoint location = [touch locationInNode:self];
            
            // 2) Detect Pressing Left Button
            if ([moveLeftButton containsPoint:location]) {
                self.isMovingLeft = YES;
                self.scrollingDirection = LEFT;
                
                if (self.isMovingRight) {
                    self.isMovingRight = NO;
                }
            }
            
            // 3) Detect Pressing Right Button
            else if ([moveRightButton containsPoint:location]) {
                self.isMovingRight = YES;
                self.scrollingDirection = RIGHT;
                
                if (self.isMovingLeft) {
                    self.isMovingLeft = NO;
                }
            }
            
            // 4) If not touching the move buttons, then jump
            else {
                [self jump];
            }
            
        }
        
    }
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // User cancelled touch. Set movement BOOLs to false
    
//    for (UITouch* touch in touches) {
//        
//        CGPoint location = [touch locationInNode:self];
//        
//        if ([moveLeftButton containsPoint:location]) {
//            // if we moved off left button, set the flag to false
//            self.scrollingDirection = UNKNOWN;
//            self.isMovingLeft = NO;
//        }
//        
//        if ([moveRightButton containsPoint:location]) {
//            // if we moved off right button, set the flag to false
//            self.scrollingDirection = UNKNOWN;
//            self.isMovingRight = NO;
//        }
//    }

    // simplify
    
    self.isMovingRight = NO;
    self.isMovingLeft = NO;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // User lifted finger. Set movement BOOLs to false
    
//    if (!self.isJumping) {
//        
//        for (UITouch* touch in touches) {
//            
//            CGPoint location = [touch locationInNode:self];
//            
//            if ([moveLeftButton containsPoint:location]) {
//                // if we moved off left button, set the flag to false
//                self.scrollingDirection = UNKNOWN;
//                self.isMovingLeft = NO;
//            }
//            
//            if ([moveRightButton containsPoint:location]) {
//                // if we moved off right button, set the flag to false
//                self.scrollingDirection = UNKNOWN;
//                self.isMovingRight = NO;
//            }
//        }
//    }
    
    // simplify
    
    self.isMovingLeft = NO;
    self.isMovingRight = NO;
    
}

//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    /*
//     *  Check if the touches that we active
//        are still being touched, if they are
//        not, unactive the movements.
//     */
//    
//    for (UITouch* touch in touches) {
//        
//        CGPoint location = [touch locationInNode:self];
//        
//        if (self.isMovingLeft && ![moveLeftButton containsPoint:location]) {
//            // if we moved off left button, set the flag to false
//            self.scrollingDirection = UNKNOWN;
//            self.isMovingLeft = NO;
//        }
//        
//        if (self.isMovingRight && ![moveRightButton containsPoint:location]) {
//            // if we moved off right button, set the flag to false
//            self.scrollingDirection = UNKNOWN;
//            self.isMovingRight = NO;
//        }
//        
//        if (self.isMovingLeft == NO && [moveLeftButton containsPoint:location]) {
//            self.scrollingDirection = LEFT;
//            self.isMovingLeft = YES;
//        }
//        
//        if (self.isMovingRight == NO && [moveRightButton containsPoint:location]) {
//            self.scrollingDirection = RIGHT;
//            self.isMovingRight = YES;
//        }
//        
//    }
//}


-(void)jump {
    
    // Determine if trump was moving, if he was jump him in that direction with a boost
    if (self.isMovingLeft) {
        
        SKAction *shortJump = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.player.frame) - kJumpAmountX, CGRectGetHeight(self.frame) - (kMoveLeftButtonHeight + kMoveButtonPadding + kPlayerHeight)) duration:kLongJumpDuration];
        self.isJumping = YES;
        [shortJump setSpeed:1.2];
        shortJump.timingMode = SKActionTimingEaseInEaseOut;
        [self.player runAction:shortJump completion:^{
        }];
        
    }
    
    else if (self.isMovingRight) {
        
        SKAction *shortJump = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.player.frame) + kJumpAmountX, CGRectGetHeight(self.frame) - (kMoveLeftButtonHeight + kMoveButtonPadding + kPlayerHeight)) duration:kLongJumpDuration];
        self.isJumping = YES;
        [shortJump setSpeed:1.2];
        shortJump.timingMode = SKActionTimingEaseInEaseOut;
        [self.player runAction:shortJump completion:^{
        }];
        
    }
    
    else {
        
        SKAction *shortJump = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.player.frame), CGRectGetMidY(self.frame)) duration:kShortJumpDuration];
        self.isJumping = YES;
        [self.player runAction:shortJump withKey:kShortJumpAnimation];
        
    }

}

//-(void)longPressTouch:(UILongPressGestureRecognizer *)press{
//    
//    /*
//     *  This long press is going to inform our
//        'simple' engine that the user still
//        wants to walk or move across the 
//        ground after the jump.
//     */
//    
//    NSLog(@"LONGGG PRESS");
//    
//    CGPoint touchView = [press locationInView:press.view];
//    touchView = [self convertPointFromView:touchView];
//    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchView];
//    
//    if (touchedNode == moveLeftButton) {
//        
//        
//    }
//    
//    else if (touchedNode == moveRightButton) {
//        
//        
//    }
//    
//}

-(void)bouncePlayerInDirection:(Direction)direction withCompletion:(Completion)completion {
    
    /*
     *  Here we will "Push" the character back to the center of the screen
     */
    
    self.isRecentering = YES;
    
    // Cancel previous animations
    [self.player removeAllActions];
    
    if (direction == RIGHT) {
        // Push Left
        
        SKAction *push = [SKAction moveTo:CGPointMake(self.player.position.x + kBoundaryPushBack, self.player.position.y + 20) duration:0.5];
        [push setSpeed:2];
        [self.player runAction:push completion:^{
            
            completion(YES);
        }];
        
    }
    
    else {
        // Push Right
        
        SKAction *push = [SKAction moveTo:CGPointMake(self.player.position.x - kBoundaryPushBack, self.player.position.y + 20) duration:0.5];
        [push setSpeed:2];
        [self.player runAction:push completion:^{
            
            completion(YES);
        }];
    }

}

-(void)pauseGame {
    
    self.isPaused = YES;
    [self.player setPaused:YES];
}

-(void)unpauseGame {
    
    self.isPaused = NO;
    [self.player setPaused:NO];
}

#pragma mark - UPDATE METHODS / COLLISION CHECK

-(void)update:(CFTimeInterval)currentTime {
    
//    NSString* currentSegment;
//    NSString* nextSegment;
    
    scoreLabel.text = [NSString stringWithFormat:@"BS1 idx %ld | BS2 idx %ld | FS1 idx %ld | FS2 idx %ld | Current ScreenSeg %ld", self.background1.index, self.background2.index,self.foreground1.index, self.foreground2.index, self.environmentManager.currentScreenOffset];
    
//    scoreLabel.text = [NSString stringWithFormat:@"Current Background Segment %ld", self.environmentManager.currentBackgroundScreenSegment];
    
    /*
     *  UPDATE EVERY FRAME
        
        1) Only perform updates to the game if upaused.
        2) Floor detection. So the player does not fall through the floor.
        3) Wall detection. This will check collision with the player and
        the edge of the screen.
        4) Scroll background. Once scrolling has commenced, we need to 
        'freeze' our Player in place as we perform the Player's walking 
        animation.
        5) Player movement. This is where we perform the walking animations 
        if the Player has pressed the 'Left' or 'Right' buttons.
     */
    
    
    // 1) Only perform updates to the game if the we are upaused.
    if (self.isPaused == NO && [self integrityCheck]) {
        
        /*
         *  2) Floor detection. So the player does not fall through the floor.
            This will remain consistant across all scene types. There will
            not be a case where we want the player to fall throught the ground.
         */
        [self floorDetection];
        
        /*
         *  3) Wall detection. This will check collision with the player and 
            the edge of the screen. This will remain consitent across all
            scene types, to some degree. Even scolling scene types will need
            to check if the player has reached the edge of the screen (example:
            if player has reached the end of the scrollable level). Because of
            that, wallDetection will be called before approachDetection.
         */
        if (!self.isRecentering) {
            [self wallDetection];
        }
        
        /*
         *  4) Scroll background. If scrolling enabled, shouldBeginScrollingInDirection
            will check if the player has moved 'approaching' a certain side of 
            the screen, or if there is enough playable room left in the level to
            scroll in that direction. This method will be overloaded in sub scenes.
         
            Once scrolling has commenced, we need to 'freeze' our Player in place
            as we perform the Player's walking animation. This will give the 
            illusion that the player is moving with the background and the 'camera'
            (we) are just following along with the action.
         */
        if (self.isScrollingEnabled && [self shouldBeginScrollingInDirection:self.scrollingDirection]) {
            
            self.isPlayerFrozen = YES;
            [self scrollEnvironment];
        }
        else {
            self.isPlayerFrozen = NO;
        }
        
        /*
         *  5) Player movement. This is where we perform the walking animations if
            the Player has pressed the 'Left' or 'Right' buttons. If the user is 
            not currently trying to move the Player around the screen, the Player
            will not move and the animation will stop.
         */
        [self movePlayerIfRequested];

    }

}

-(BOOL)integrityCheck {
    
    /*  (Called each frame from update: method)
     *  This is where we check if everything is as we expect (example: player is not blown out off screen with the physics and so forth...)
     */
    
    BOOL ok = YES;
    
    if (self.player.position.y < self.floor.position.y) {
        scoreLabel.text = @"Player off screen!";
        ok = NO;
        [self disableGravity];
        self.player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self enableGravity];
    }
    
    return ok;
}

-(BOOL)wallDetection {
    
    /*  (Called each frame from update: method)
     *  This checks if player's has run into our invisible
        wall at the edge of the screen. IF they have, we
        should bounce them back away from either side
     */
    
    Direction direction;
    BOOL rightWallCollision = CGRectIntersectsRect(self.player.frame, self.rightWall.frame);
    BOOL leftWallCollision = CGRectIntersectsRect(self.player.frame, self.leftWall.frame);
    
    if (rightWallCollision || leftWallCollision) {
        
        if (rightWallCollision) {
            direction = LEFT;
        }
        else {
            direction = RIGHT;
        }
        
        // disable gravity
        [self disableGravity];
        
        // AT THE WALL... bounce them back to the center
        [self bouncePlayerInDirection:direction withCompletion:^(BOOL completed) {
            
            if (completed) {
                [self enableGravity];
                self.isRecentering = NO;
            }
        }];
        
        return YES;
    }
    
    else {
        
        // MOVEMENT
        return NO;
    }
}

-(void)floorDetection {
    
    /*  (Called each frame from update: method)
     *  This checks if player's feet is touching the floor
        This should turn off gravity effect so that the player
        does not fall through the floor. If the player is not
        touching the floor, we need to turn on gravity.
     */
    
    if (CGRectIntersectsRect(self.player.frame, self.floor.frame)) {
        
        [self disableGravity];
        self.isTouchingThefloor = YES;
        self.isJumping = NO;
    }
    
    else {
        
        [self enableGravity];
        self.isTouchingThefloor = NO;
    }
}

-(void)disableGravity {
    
    self.player.physicsBody.dynamic = NO;
}

-(void)enableGravity {
    
    self.player.physicsBody.dynamic = YES;
}

#pragma mark - CONTROLS

-(void)movePlayerIfRequested {
    
    /*
     *  Player has requested to move LEFT.
        
        1) Perform animation to walk Player
     
        2) Check whether the player is 'frozen'.
        This will determine whether we need to 
        physically move the sprite around the 
        screen.
     
        3) Move the Player around the screen
     */
    if (self.isMovingLeft==YES && self.isTouchingThefloor == YES && self.isJumping == NO && self.isRecentering == NO) {
        
        // 1) Perform animation to walk Player
        [self performWalkingAnimationInDirection:LEFT];
        
        // 2) Check whether the player is 'frozen'.
        if (!self.isPlayerFrozen) {
            
            // 3) Move the Player around the screen
            self.player.anchorPoint = CGPointMake(0.5, 0.5);
            
            CGPoint moveToPoint = CGPointMake(CGRectGetMidX(self.player.frame) - kMovementAmount, self.player.position.y);
            
            SKAction *shortMovement = [SKAction moveTo:moveToPoint duration:kMovementDuration];
            shortMovement.speed = 15;
            shortMovement.timingMode = SKActionTimingEaseIn;
            [self.player runAction:shortMovement completion:^{
                
            }];
            
        }
        
    }
    
    else if (self.isMovingRight==YES && self.isTouchingThefloor == YES && self.isJumping == NO && self.isRecentering == NO) {
        
        // 1) Perform animation to walk Player
        [self performWalkingAnimationInDirection:RIGHT];
        
        // 2) Check whether the player is 'frozen'.
        if (!self.isPlayerFrozen) {
            
            // 3) Move the Player around the screen
            self.player.anchorPoint = CGPointMake(0.5, 0.5);
            
            CGPoint moveToPoint = CGPointMake(CGRectGetMidX(self.player.frame) + kMovementAmount, self.player.position.y);
            
            SKAction *shortMovement = [SKAction moveTo:moveToPoint duration:kMovementDuration];
            shortMovement.speed = 15;
            shortMovement.timingMode = SKActionTimingEaseIn;
            [self.player runAction:shortMovement completion:^{
                
            }];
            
        }
    }
    
    else {
        [self stopWalkingAnimationInDirection:self.scrollingDirection];
    }
    
}

#pragma mark - SCROLLING

-(void)scrollEnvironment {
    
    // Update Environment Manager
    self.environmentManager.scrollingDirection = self.scrollingDirection;
    [self.environmentManager updateCurrentOffsetWithOffset:kMovementAmount * self.player.speed];
    
    // BACKGROUND
    [self.environmentManager monitorBackgroundForUpdates];
    [self.background1 scrollInDirection:self.scrollingDirection];
    [self.background2 scrollInDirection:self.scrollingDirection];
    
    // MIDDLEGROUND
//    [self.environmentManager monitorMiddlegroundForUpdates];
//    [self.middleground1 scrollInDirection:self.scrollingDirection];
//    [self.middleground2 scrollInDirection:self.scrollingDirection];
    
    // FOREGROUND
    [self.environmentManager monitorForegroundForUpdates];
    [self.foreground1 scrollInDirection:self.scrollingDirection];
    [self.foreground2 scrollInDirection:self.scrollingDirection];
    
}

-(BOOL)shouldBeginScrollingInDirection:(Direction)direction {
    
    /*
     *  Depending upon each level, and current
        situations in each level, this BOOL
        returned needs to be overloaded by 
        each subclassed scene.
     */
    
    return NO;
}

-(void)performWalkingAnimationInDirection:(Direction)direction {
    /*
     *  This will make the Player look like 
        they are walking around. Animations 
        will likly be in one direction (left).
        Check the direction and if it is the 
        opposite of the direction of the 
        animation in bundle, then use method
        to 'flip' images in opposite direction.
     */
    
}

-(void)stopWalkingAnimationInDirection:(Direction)direction  {
    // Stop walking animation and leave Player
    // looking in last walked direction
    
}

@end
