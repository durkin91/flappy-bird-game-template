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


@implementation Options {
    CCButton *_toggleSoundOnOffButton;
    NSUInteger allCoins;
    NSString *allCoinsString;
}

- (void) backButtonTapped {
    
    [Options playTapSound];
    
    CCScene *mainMenuScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

#pragma mark -
#pragma mark Sounds and music


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

#pragma mark - Game difficulty

+ (BOOL)isEasy {
    
    NSString *gameDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY];
    
    if ([gameDifficulty isEqualToString:kEASY_DIFFICULTY]) {
        return YES;
    }
    
    else return NO;
}

+ (BOOL)isMedium {
    
    NSString *gameDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY];
    
    if ([gameDifficulty isEqualToString:kMEDIUM_DIFFICULTY]) {
        return YES;
    }
    
    else return NO;
}

+ (BOOL)isHard {
    
    NSString *gameDifficulty = [[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY];
    
    if ([gameDifficulty isEqualToString:kHARD_DIFFICULTY]) {
        return YES;
    }
    
    else return NO;
}


@end
