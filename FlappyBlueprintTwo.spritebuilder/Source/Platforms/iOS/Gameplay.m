//
//  Gameplay.m
//  FlappyBlueprintTwo
/*
 * Copyright (c) 2014 Rebeloper. All rights reserved.
 *
 *      http://www.rebeloper.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "Gameplay.h"
#import "Defaults.h"
#import "Math.h"
#import "Obstacle.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Score.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "AppDelegate.h"
#import "Options.h"

void dispatch_after_delta(float delta, dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_hero;
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
    NSTimeInterval _sinceTouch;
    NSMutableArray *_obstacles;
    
    BOOL _gameOver;
    BOOL _nearGameOver;
    CGFloat _scrollSpeed;
    
    CCSprite *_continuePanel;
    CCButton *_playOnButton;
    CCButton *_endGameButton;
    
    BOOL hasTouched;
    
    CCLabelBMFont *_currentScoreLabel;
    uint32_t currentScore;
    NSString *currentScoreString;
    
    CCSprite *_coinCountSymbol;
    
    CCLabelBMFont *_currentCoinsLabel;
    uint32_t currentCoins;
    NSString *currentCoinsString;
    
    CGSize theViewSize;
    
    CGFloat _distanceBetweenObstacles;
    
    CCSprite *_fog;
    
    CGFloat _deltaSinceTouch;
    
    CGFloat _heroImpulse;
    CGFloat _heroAngularImpulse;
    CGFloat _heroClampVelocity;
    CGFloat _heroAngularImpulse2;
    
    int coinsToAdd;
    
    CCButton *_boostButton;
    CCButton *_superBoostButton;
    
    CCLabelBMFont *_countdownLabel;
    NSUInteger countdown;
    NSString *countdownString;
    
    NSTimer *timer;
    NSUInteger currSeconds;
    NSString *currSecondsString;
    
    CCButton *_finalBlastButton;
    CCButton *_finalBlastCanceledButton;
    
    CCPhysicsNode *_physicsNodeCity;
    CCNode *_city1;
    CCNode *_city2;
    NSArray *_cities;
    
    CCButton *_togglePauseOnOffButton;
    
    CCActionRepeatForever *repeatFloating;
    
    CCLabelBMFont *_gamePausedLabel;
    NSString *gamePausedString;
    BOOL _gameIsPaused;

}

- (void)didLoadFromCCB {
    
    [self startGameWithScore:[[NSUserDefaults standardUserDefaults] integerForKey:theCurrentScore] andCoins:[[NSUserDefaults standardUserDefaults] integerForKey:theCurrentCoins]];
    
}

- (void) startGameWithScore:(int) theScore andCoins:(int) theCoins {
  
    [Options playBackgroundMusic];
  
    _gameOver = NO;
    _nearGameOver = NO;
    _gameIsPaused = NO;
    
    _finalBlastButton.visible = NO;
    _finalBlastCanceledButton.visible = NO;
    
    _finalBlastButton.zOrder = GameplayZeeOrderCoinsCount;
    _finalBlastCanceledButton.zOrder = GameplayZeeOrderCoinsCount;
    
    _boostButton.zOrder = GameplayZeeOrderCoinsCount;
    _superBoostButton.zOrder = GameplayZeeOrderCoinsCount;
    
    _togglePauseOnOffButton.zOrder = GameplayZeeOrderCoinsCount;
    _togglePauseOnOffButton.visible = NO;
  
  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_BOOST_ACTIVE];
  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_SUPER_BOOST_ACTIVE];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
    //IS_BOOST_ACTIVE = NO;
    //IS_SUPER_BOOST_ACTIVE = NO;
    
    //Set these up. They were originally checking whether there was enough store inventory, but that is irrelevant now.
    _boostButton.visible = NO;
    _superBoostButton.visible = NO;
    coinsToAdd = 1;
    _distanceBetweenObstacles = DISTANCE_BETWEEN_PIPES_NORMAL;
    _fog.visible = NO;
    _scrollSpeed = SCROLL_SPEED_NORMAL;
    
    _physicsNode.gravity = ccp(0, -700);
    _deltaSinceTouch = 0.5f;
    _physicsNode.gravity = ccp(0, -700);
    _heroImpulse = 400;
    _heroAngularImpulse = 10000;
    _heroClampVelocity = 200;
    _heroAngularImpulse2 = -40000;
    _currentScoreLabel.visible = YES;
  
    theViewSize = [[CCDirector sharedDirector] viewSize];

    _coinCountSymbol.zOrder =GameplayZeeOrderCoinsCount;
    
    [self addCoinsLabel];
    
    [self addScoreLabel];
    
    [self addGamePausedLabel];
    
    hasTouched = NO;
  
    _continuePanel.visible = NO;
    _playOnButton.visible = NO;
    _endGameButton.visible = NO;
    
    // set this class as delegate
    _physicsNode.collisionDelegate = self;
    
    _physicsNodeCity.zOrder = GameplayZeeOrderPhysicsNodeCity;
    _physicsNode.zOrder = GameplayZeeOrderPhysicsNode;
  
    _hero = [CCBReader load:[self heroName]];
    _hero.position = ccp(90, 420);
  
    // setting hero as a static body
    [[_physicsNode space] addPostStepBlock:^{
        _hero.physicsBody.type = CCPhysicsBodyTypeStatic;
    } key:_hero];
    // adding floating animation
    CCActionMoveBy *moveBy = [CCActionMoveBy actionWithDuration:1.f position:ccp(0, -20)];
    CCActionInterval *reverseMovement = [moveBy reverse];
    CCActionSequence *floatSequence = [CCActionSequence actionWithArray:@[moveBy, reverseMovement]];
    CCActionEaseBounce *floating = [CCActionEaseBounce actionWithAction:floatSequence];
    repeatFloating = [CCActionRepeatForever actionWithAction:floating];
    [_hero runAction:repeatFloating];
  
    [_physicsNode addChild:_hero];
    _hero.physicsBody.collisionType = @"hero";
    _hero.zOrder = DrawingOrderHero;
   
    _grounds = @[_ground1, _ground2];
    for (CCNode *ground in _grounds) {
        ground.physicsBody.collisionType = @"obstacle";
        ground.zOrder = DrawingOrderGround;
    }
    
    self.userInteractionEnabled = TRUE;
    
    _obstacles = [NSMutableArray array];
    
    _cities = @[_city1, _city2];
}

- (NSString*) heroName {
    
    NSString *heroName;
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:heroType]) {
        case 1:
            heroName = @"Hero01";
            break;
        case 2:
            heroName = @"Hero02";
            break;
        case 3:
            heroName = @"Hero03";
            break;
        case 4:
            heroName = @"Hero04";
            break;
        case 5:
            heroName = @"Hero05";
            break;
        case 6:
            heroName = @"Hero06";
            break;
        case 7:
            heroName = @"Hero07";
            break;
        case 8:
            heroName = @"Hero08";
            break;
        case 9:
            heroName = [self randomHeroName];
            break;
            
        default:
            break;
    }
    
    return heroName;
}

- (NSString*) randomHeroName {
    
    NSString *heroName;
    
    int random = [Math randomIntBetween:1 and:9];
    
    switch (random) {
        case 1:
            heroName = @"Hero01";
            break;
        case 2:
            heroName = @"Hero02";
            break;
        case 3:
            heroName = @"Hero03";
            break;
        case 4:
            heroName = @"Hero04";
            break;
        case 5:
            heroName = @"Hero05";
            break;
        case 6:
            heroName = @"Hero06";
            break;
        case 7:
            heroName = @"Hero07";
            break;
        case 8:
            heroName = @"Hero08";
            break;
            
        default:
            break;
    }
    
    return heroName;
}

- (void)update:(CCTime)delta {
    
    if (!hasTouched) {
        return;
    }
    
    _hero.position = ccp(_hero.position.x + delta * _scrollSpeed, _hero.position.y);
    _physicsNode.position = ccp(_physicsNode.position.x - (_scrollSpeed *delta), _physicsNode.position.y);
    _physicsNodeCity.position = ccp(_physicsNodeCity.position.x - ((_scrollSpeed/10) *delta), _physicsNodeCity.position.y);
    
    // clamp hero to top
    if (_hero.position.y >= theViewSize.height) {
        _hero.position = ccp(_hero.position.x, theViewSize.height);
    }
    
    // clamp velocity
    float yVelocity = clampf(_hero.physicsBody.velocity.y, -1 * MAXFLOAT, _heroClampVelocity);
    _hero.physicsBody.velocity = ccp(0, yVelocity);
    
    _sinceTouch += delta;
    _hero.rotation = clampf(_hero.rotation, -30.f, 90.f);
    if (_hero.physicsBody.allowsRotation) {
        float angularVelocity = clampf(_hero.physicsBody.angularVelocity, -2.f, 1.f);
        _hero.physicsBody.angularVelocity = angularVelocity;
    }
    if ((_sinceTouch > _deltaSinceTouch)) {
        [_hero.physicsBody applyAngularImpulse:_heroAngularImpulse2*delta];
    }
    
    // loop the ground
    for (CCNode *ground in _grounds) {
        // get the world position of the ground
        CGPoint groundWorldPosition = [_physicsNode convertToWorldSpace:ground.position];
        // get the screen position of the ground
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (groundScreenPosition.x <= (-1 * ground.contentSize.width)) {
            ground.position = ccp(ground.position.x + 2 * ground.contentSize.width, ground.position.y);
        }
    }
    
    // loop the city
    for (CCNode *city in _cities) {
        // get the world position of the city
        CGPoint cityWorldPosition = [_physicsNodeCity convertToWorldSpace:city.position];
        // get the screen position of the city
        CGPoint cityScreenPosition = [self convertToNodeSpace:cityWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (cityScreenPosition.x <= (-1 * city.contentSize.width)) {
            city.position = ccp(city.position.x + 2 * city.contentSize.width, city.position.y);
        }
    }
    
    NSMutableArray *offScreenObstacles = nil;
    for (CCNode *obstacle in _obstacles) {
        CGPoint obstacleWorldPosition = [_physicsNode convertToWorldSpace:obstacle.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace:obstacleWorldPosition];
        if (obstacleScreenPosition.x < (-2 * obstacle.contentSize.width)) {
            if (!offScreenObstacles) {
                offScreenObstacles = [NSMutableArray array];
            }
            [offScreenObstacles addObject:obstacle];
        }
    }
    for (CCNode *obstacleToRemove in offScreenObstacles) {
        [obstacleToRemove removeFromParent];
        [_obstacles removeObject:obstacleToRemove];
        // for each removed obstacle, add a new one
        [self spawnNewObstacle];
    }
}

- (void)spawnNewObstacle {
    CCNode *previousObstacle = [_obstacles lastObject];
    CGFloat previousObstacleXPosition = previousObstacle.position.x;
    if (!previousObstacle) {
        // this is the first obstacle
        previousObstacleXPosition = firstObstaclePosition;
    }
    Obstacle *obstacle = (Obstacle *)[CCBReader load:[self obstacleName]];
    obstacle.position = ccp(previousObstacleXPosition + _distanceBetweenObstacles, 0);
    [obstacle setupRandomPosition];
    obstacle.zOrder = DrawingOrderPipes;
    [_physicsNode addChild:obstacle];
    [_obstacles addObject:obstacle];
}

- (NSString*) obstacleName {
    
    NSString *obstacleName;
    
    if (!USE_RANDOM_PIPES) {
        obstacleName = @"Obstacle01";
    } else {
        int random = [Math randomIntBetween:1 and:4];
        
        //random = 1;
        
        switch (random) {
            case 1:
                obstacleName = @"Obstacle01";
                break;
            case 2:
                obstacleName = @"Obstacle02";
                break;
            case 3:
                obstacleName = @"Obstacle03";
                break;
                
            default:
                break;
        }
    }
    
    return obstacleName;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (!_gameOver & !_nearGameOver & !_gameIsPaused) {
        [Options playWoshSound];
        [_hero.physicsBody applyImpulse:ccp(0, _heroImpulse)];
        [_hero.physicsBody applyAngularImpulse:_heroAngularImpulse];
        _sinceTouch = 0.f;
    }
    
    if (!hasTouched) {
        // this is the first touch
        
        // removing boostButtons
        _boostButton.visible = NO;
        _superBoostButton.visible = NO;
        
        // showing pause button
        _togglePauseOnOffButton.visible = YES;
        
        // stopping all current actions on hero
        [_hero stopAllActions];
        
        // setting hero as a dynamic body
        [[_physicsNode space] addPostStepBlock:^{
            _hero.physicsBody.type = CCPhysicsBodyTypeDynamic;
        } key:_hero];
        
        // spawning first 4 obstacles
        [self spawnNewObstacle];
        [self spawnNewObstacle];
        [self spawnNewObstacle];
        [self spawnNewObstacle];
        
        hasTouched = YES;
    }
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero obstacle:(CCNode *)obstacle {
    
    if (_gameOver || _nearGameOver) {
        return TRUE;
    }
    
    [Options playHitSound];
    
    [self nearGameOver];
    
    return TRUE;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero coin:(CCNode *)coin {
    
    [Options playCoinSound];
    
    //hasCollectedCoin = YES;
    coin.physicsBody.collisionType = @"none";
    
    coin.visible = NO;
    
    NSLog(@"Coin!");
    
    // updating coins
    currentCoins = currentCoins + coinsToAdd;
    currentCoinsString = [NSString stringWithFormat:@"%li",(long)currentCoins];
    _currentCoinsLabel.string = currentCoinsString;
    [StoreInventory giveAmount:coinsToAdd ofItem:COINS_CURRENCY_ITEM_ID];
    
    return TRUE;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero gate:(CCNode *)gate {
    
    gate.physicsBody.collisionType = @"none";
    
    NSLog(@"Gate!");
    
    // updating score
    currentScore = currentScore + 1;
    currentScoreString = [NSString stringWithFormat:@"%li",(long)currentScore];
    _currentScoreLabel.string = currentScoreString;
    
    return TRUE;
}

- (void) addCoinsLabel {
    
    currentCoins = [[NSUserDefaults standardUserDefaults] integerForKey:theCurrentCoins];
    currentCoinsString = [NSString stringWithFormat:@"%li",(long)currentCoins];
    
    _currentCoinsLabel = [CCLabelBMFont labelWithString:currentCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _currentCoinsLabel.anchorPoint = ccp(1.0, 0.5);
    _currentCoinsLabel.position = ccp(295, 495);
    _currentCoinsLabel.scale = 0.4f;
    _currentCoinsLabel.zOrder = GameplayZeeOrderCoinsCount;
    
    [self addChild:_currentCoinsLabel];
}

- (void) addScoreLabel {
    
    currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:theCurrentScore];
    currentScoreString = [NSString stringWithFormat:@"%li",(long)currentScore];
    
    _currentScoreLabel = [CCLabelBMFont labelWithString:currentScoreString fntFile:@"MyAwesomeBMFont.fnt"];
    _currentScoreLabel.anchorPoint = ccp(0.5, 0.0);
    _currentScoreLabel.position = ccp(192, 100);
    _currentScoreLabel.scale = 4.f;
    _currentScoreLabel.opacity = 0.2;
    _currentScoreLabel.zOrder = GameplayZeeOrderScore;
    
    [self addChild:_currentScoreLabel];
}

- (void) addGamePausedLabel {
    gamePausedString = @"Paused";
    
    _gamePausedLabel = [CCLabelBMFont labelWithString:gamePausedString fntFile:@"MyAwesomeBMFont.fnt"];
    _gamePausedLabel.anchorPoint = ccp(0.5, 0.5);
    _gamePausedLabel.position = ccp(192, 300);
    _gamePausedLabel.scale = 0.8f;
    _gamePausedLabel.zOrder = GameplayZeeOrderCoinsCount;
    _gamePausedLabel.visible = NO;
    
    [self addChild:_gamePausedLabel];
}

- (void) showContinuePanel {
    _continuePanel.visible = YES;
    _playOnButton.visible = YES;
    _endGameButton.visible = YES;
    
    _continuePanel.zOrder = GameplayZeeOrderContinuePanel;
    _playOnButton.zOrder = GameplayZeeOrderContinuePanelButton;
    _endGameButton.zOrder = GameplayZeeOrderContinuePanelButton;

}

- (void) nearGameOver {
    if (!_nearGameOver) {
        
        [AppController captureScreenshot];
        
        _togglePauseOnOffButton.visible = NO;

        _physicsNode.gravity = ccp(0, -700);
        _scrollSpeed = 0.f;
        _nearGameOver = TRUE;
        _hero.rotation = 90.f;
        _hero.physicsBody.allowsRotation = FALSE;
        [_hero stopAllActions];
        CCActionMoveBy *moveBy = [CCActionMoveBy actionWithDuration:0.05f position:ccp(2, -2)];
        CCActionInterval *reverseMovement = [moveBy reverse];
        CCActionSequence *shakeSequence = [CCActionSequence actionWithArray:@[moveBy, reverseMovement]];
        CCActionEaseBounce *bounce = [CCActionEaseBounce actionWithAction:shakeSequence];
        CCActionRepeat *repeatBounce = [CCActionRepeat actionWithAction:bounce times:5];
        [self runAction:repeatBounce];
        
        [self gameOver];
        
    }
}


- (void)gameOver {
    if (!_gameOver) {
        
        _gameOver = TRUE;
        
        dispatch_after_delta(1.f , ^{
            
            [self showGameOverScene];
            
        });
        
    }
}

- (void) showGameOverScene {
    
    // checking if it is new best score
    if(currentScore > [Score bestScore]){
      
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isNewBestScore];
      [[NSUserDefaults standardUserDefaults] synchronize];
      
        //isNewBestScore = YES;
    } else {
      
      [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isNewBestScore];
      [[NSUserDefaults standardUserDefaults] synchronize];

        //isNewBestScore = NO;
    }
    
    [Score registerScore:currentScore];
    
    [Score setCurrentCoins:currentCoins];
    
    
    // resetting params
  [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:theCurrentScore];
  [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:theCurrentCoins];
  [[NSUserDefaults standardUserDefaults] synchronize];
    //theCurrentScore = 0;
    //theCurrentCoins = 0;
    
    [Options stopBackgroundMusic];
    
    CCScene *gameOverScene = [CCBReader loadAsScene:@"GameOver"];
    [[CCDirector sharedDirector] replaceScene:gameOverScene];
}

- (void) showCountdownForSeconds: (NSUInteger) seconds {
    [self addCountdownLabelForSeconds:seconds];
    [self startTimerWithSeconds:seconds];
}

- (void) addCountdownLabelForSeconds: (NSUInteger) seconds {
    countdown = seconds;
    countdownString = [NSString stringWithFormat:@"%li",(long)countdown];
    
    _countdownLabel = [CCLabelBMFont labelWithString:countdownString fntFile:@"MyAwesomeBMFont.fnt"];
    _countdownLabel.anchorPoint = ccp(0.5, 0.5);
    _countdownLabel.position = ccp(192, 480);
    _countdownLabel.scale = 0.7f;
    //_currentScoreLabel.opacity = 0.2;
    _countdownLabel.zOrder = GameplayZeeOrderCoinsCount;
    
    [self addChild:_countdownLabel];
}

-(void)startTimerWithSeconds: (NSUInteger) seconds
{
    currSeconds = seconds;
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)timerFired
{
  
    if (!_gameOver) {
        if(currSeconds>0)
        {
            currSeconds-=1;
            
            currSecondsString = [NSString stringWithFormat:@"%li",(long)currSeconds];
            _countdownLabel.string = currSecondsString;
        }
        else
        {
            [timer invalidate];
            _countdownLabel.visible = NO;
          
          // showing pause button
          _togglePauseOnOffButton.visible = YES;
        }
        
        if (_nearGameOver) {
            [timer invalidate];
            _countdownLabel.visible = NO;
          
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_BOOST_ACTIVE];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_SUPER_BOOST_ACTIVE];
          [[NSUserDefaults standardUserDefaults] synchronize];
            
            //IS_BOOST_ACTIVE = NO;
            //IS_SUPER_BOOST_ACTIVE = NO;
        }
        
    }
    
    
}

- (void) togglePauseOnOffButtonTapped:(id) sender {

    [Options playTapSound];
    
    _togglePauseOnOffButton = sender;
    
    if (_togglePauseOnOffButton.selected)
    {
        NSLog(@"Pause is ON.");
        _gameIsPaused = YES;
        
        _gamePausedLabel.visible = YES;
    
        _scrollSpeed = 0.f;
        
        // setting hero as a static body
        [[_physicsNode space] addPostStepBlock:^{
            _hero.physicsBody.type = CCPhysicsBodyTypeStatic;
        } key:_hero];
        
        CCAnimationManager* animationManager = _hero.userObject;
        [animationManager setPaused:YES];
        
    }
    else
    {
        NSLog(@"Pause is OFF.");
        _gameIsPaused = NO;
        
        _gamePausedLabel.visible = NO;
        
        _scrollSpeed = SCROLL_SPEED_NORMAL;
        
        // setting hero as a dynamic body
        [[_physicsNode space] addPostStepBlock:^{
            _hero.physicsBody.type = CCPhysicsBodyTypeDynamic;
        } key:_hero];
        
        CCAnimationManager* animationManager = _hero.userObject;
        [animationManager setPaused:NO];
        
    }
    
}

@end
