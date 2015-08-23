//
//  Obstacle.m
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

#import "Obstacle.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "Math.h"
#import "Defaults.h"

@implementation Obstacle {
    CCNode *_topPipe;
    CCNode *_bottomPipe;
    CCNode *_coin;
    CCNode *_gate;
    
    CGFloat pipeDistance;
    
    CGSize viewSize;
    
    CGFloat minimumYPositionTopPipe;
    CGFloat maximumYPositionBottomPipe;
    CGFloat maximumYPositionTopPipe;
    
}

#define ARC4RANDOM_MAX      0x100000000

//// visibility on a 3,5-inch iPhone ends a 88 points and we want some meat
//static const CGFloat minimumYPositionTopPipe = 120.f; //48.f
//// visibility ends at 480 and we want some meat
//static const CGFloat maximumYPositionBottomPipe = 400.f; //400.f
//// distance between top and bottom pipe
//static const CGFloat pipeDistance = 112.f;
// calculate the end of the range of top pipe
//static const CGFloat maximumYPositionTopPipe = maximumYPositionBottomPipe - pipeDistance;


- (void)didLoadFromCCB {
    
    //Setup settings for different device types
    viewSize = [[CCDirector sharedDirector] viewSize];
    
    //iPhone 6
    if (viewSize.height == 667 && viewSize.width == 375) {
        
        NSLog(@"Is an iPhone 6");
        minimumYPositionTopPipe = 240.f;
        maximumYPositionBottomPipe = 100.f;
        pipeDistance = 112.f;
        
    }
    
    //iPhone 6+
    else if (viewSize.height == 736 && viewSize.width == 414) {
        
        NSLog(@"Is a 6+");
        minimumYPositionTopPipe = 200.f;
        maximumYPositionBottomPipe = 80.f;
        
    }
    
    //iPhone 4s
    else if (viewSize.height == 480 && viewSize.width == 320) {
        
        NSLog(@"Is a 4s");
        minimumYPositionTopPipe = 150.f;
        maximumYPositionBottomPipe = 370.f;
        
    }
    
    //iPad
    else if (viewSize.height == 512 && viewSize.width == 384) {
        
        NSLog(@"Is an ipad");
        minimumYPositionTopPipe = 120.f;
        maximumYPositionBottomPipe = 370.f;
        
    }
    
    //iPhone 5 and everything else
    else {
        
        minimumYPositionTopPipe = 80.f;
        maximumYPositionBottomPipe = 370.f;
        
    }
    
    //Change pipe distance (the gap btwn pipes) according to level difficulty
    NSString *gameDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY];
    
    if ([gameDifficulty isEqualToString:kEASY_DIFFICULTY]) {
        
        pipeDistance = PIPE_DISTANCE_EASY;
        
    }
    
    else if ([gameDifficulty isEqualToString:kMEDIUM_DIFFICULTY]) {
        
        pipeDistance = PIPE_DISTANCE_MEDIUM;
        
    }
    
    else if ([gameDifficulty isEqualToString:kHARD_DIFFICULTY]) {
        
        pipeDistance = PIPE_DISTANCE_HARD;
        
    }
    
    else {
        pipeDistance = PIPE_DISTANCE_MEDIUM;
    }
    

    maximumYPositionTopPipe = maximumYPositionBottomPipe - pipeDistance;

    _topPipe.physicsBody.collisionType = @"obstacle";
    _topPipe.physicsBody.sensor = TRUE;
    _bottomPipe.physicsBody.collisionType = @"obstacle";
    _bottomPipe.physicsBody.sensor = TRUE;
    _coin.physicsBody.collisionType = @"coin";
    _coin.physicsBody.sensor = TRUE;
    _gate.physicsBody.collisionType = @"gate";
    _gate.physicsBody.sensor = TRUE;
    
    if ([StoreInventory isVirtualGoodWithItemIdEquipped:GADGETS_GOOD_06_ITEM_ID]) {
        pipeDistance = [Math randomFloatBetween:112.f and:312.f];
    } 
    
    if ([StoreInventory isVirtualGoodWithItemIdEquipped:GADGETS_GOOD_07_ITEM_ID]) {
        _topPipe.visible = NO;
        _bottomPipe.visible = NO;
        _topPipe.physicsBody.collisionType = @"none";
        _bottomPipe.physicsBody.collisionType = @"none";
        _gate.physicsBody.collisionType = @"none";
    } else {
        _topPipe.visible = YES;
        _bottomPipe.visible = YES;
        _topPipe.physicsBody.collisionType = @"obstacle";
        _bottomPipe.physicsBody.collisionType = @"obstacle";
        _gate.physicsBody.collisionType = @"gate";
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_BOOST_ACTIVE]) {
        _topPipe.physicsBody.collisionType = @"none";
        _bottomPipe.physicsBody.collisionType = @"none";
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_SUPER_BOOST_ACTIVE]) {
        _topPipe.physicsBody.collisionType = @"none";
        _bottomPipe.physicsBody.collisionType = @"none";
    }
    
}

- (void)setupRandomPositionWithPipeDistance:(CGFloat)distanceBetweenPipes {
    
    // value between 0.f and 1.f
    CGFloat randomPipe = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat randomCoin = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat range = maximumYPositionTopPipe - minimumYPositionTopPipe;
    _topPipe.position = ccp(_topPipe.position.x, minimumYPositionTopPipe + (randomPipe * range));
    _bottomPipe.position = ccp(_bottomPipe.position.x, _topPipe.position.y + pipeDistance);
    _coin.position = ccp((distanceBetweenPipes / 2) + 40, minimumYPositionTopPipe + (randomCoin * range));
    
}


@end
