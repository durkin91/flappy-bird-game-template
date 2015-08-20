//
//  Options.m
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

#import "Options.h"
#import "Defaults.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import <Chartboost/Chartboost.h>
#import "iRate.h"
#import "Flurry.h"

@implementation Options {
    CCButton *_toggleSoundOnOffButton;
    
    CCLabelBMFont *_allCoinsLabel;
    NSUInteger allCoins;
    NSString *allCoinsString;
}

- (void)didLoadFromCCB {
    
    [self addAllCoinsLabel];
    
}

- (void) addAllCoinsLabel {
    allCoins = [StoreInventory getItemBalance:COINS_CURRENCY_ITEM_ID];
    allCoinsString = [NSString stringWithFormat:@"%li",(long)allCoins];
    
    _allCoinsLabel = [CCLabelBMFont labelWithString:allCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _allCoinsLabel.anchorPoint = ccp(1.0, 0.5);
    _allCoinsLabel.position = ccp(280, 500);
    _allCoinsLabel.scale = 0.7f;
    
    [self addChild:_allCoinsLabel];
}

- (void) moreGamesButtonTapped {
    
    // FLURRY LOG
    [Flurry logEvent:@"[Options] More games button tapped."];
    [Options playTapSound];
    
    // Show more apps
    [Chartboost showMoreApps:CBLocationSettings];
    
    // Cache more apps
    if (![Chartboost hasMoreApps:CBLocationSettings]) {
        [Chartboost cacheMoreApps:CBLocationSettings];
    }
}

- (void) rateButtonTapped {
    
    // FLURRY LOG
    [Flurry logEvent:@"[Options] Rate button tapped."];
    [Options playTapSound];
    
    [[iRate sharedInstance] openRatingsPageInAppStore];
}

- (void) shopCoinsButtonTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Options] Shop Coins button tapped."];
    [Options playTapSound];
    
    CCScene *shopCoinsScene = [CCBReader loadAsScene:@"ShopCoins"];
    [[CCDirector sharedDirector] replaceScene:shopCoinsScene];
}

- (void) backButtonTapped {
    
    [Options playTapSound];
    
    CCScene *mainMenuScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

#pragma mark -
#pragma mark Sounds and music

- (void) toggleSoundOnOffButtonTapped:(id) sender {
    
    // FLURRY LOG
    [Flurry logEvent:@"[Options] Toggle sound button tapped."];
    [Options playTapSound];
    
    _toggleSoundOnOffButton = sender;
    
    if (_toggleSoundOnOffButton.selected)
    {
        NSLog(@"Sound is OFF.");
        //[Options stopBackgroundMusic];
        [Options registerFXState:NO];
    }
    else
    {
        NSLog(@"Sound is ON.");
        [Options registerFXState:YES];
        //[Options playBackgroundMusic];
    }
    
}

+ (void) registerFXState:(BOOL) onOrOff {
    [[NSUserDefaults standardUserDefaults] setBool:onOrOff forKey:kFXState];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL) getFXState
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kFXState];
}

+ (void) playTapSound {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"tap.wav"];
        [audio preloadEffect:@"tap.wav"];
    }
    
}

+ (void) playHitSound {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"hit.wav"];
        [audio preloadEffect:@"hit.wav"];
    }
}

+ (void) playWoshSound {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"wosh.wav"];
        [audio preloadEffect:@"wosh.wav"];
    }
}

+ (void) playCoinSound {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"coin.wav"];
        [audio preloadEffect:@"coin.wav"];
    }
}

+ (void) playBombSound {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play sound effect
        [audio playEffect:@"bomb.wav"];
        [audio preloadEffect:@"bomb.wav"];
    }
}

+ (void) playBackgroundMusic {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play background music
        [audio playBg:@"BackgroundMusic.mp3" loop:YES];
    }
}

+ (void) stopBackgroundMusic {
    if ([self getFXState]) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // stop background music
        [audio stopBg];
    }
}


@end
