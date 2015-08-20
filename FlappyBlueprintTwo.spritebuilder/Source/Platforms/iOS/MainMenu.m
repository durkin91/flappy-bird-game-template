//
//  MainMenu.m
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

#import "MainMenu.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "RootViewControllerInterface.h"
#import "AppDelegate.h"
#import "Options.h"

@implementation MainMenu {
    CCButton *_toggleSoundOnOffButton;
    NSUInteger allCoins;
    NSString *allCoinsString;
}

- (void) playButtonTapped {
    
    [Options playTapSound];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


- (void) optionsButtonTapped {
    
    [Options playTapSound];
    
    CCScene *optionsScene = [CCBReader loadAsScene:@"Options"];
    [[CCDirector sharedDirector] replaceScene:optionsScene];
}

- (void) toggleSoundOnOffButtonTapped:(id) sender {
    
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

@end
