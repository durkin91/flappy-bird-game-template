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
#import "Nextpeer/Nextpeer.h"
#import "AppDelegate.h"
#import "Options.h"

@implementation MainMenu {
    CCLabelBMFont *_allCoinsLabel;
    NSUInteger allCoins;
    NSString *allCoinsString;
}

- (void)didLoadFromCCB {
    
    // showing ads at startup
    [AppController showAdsAtStartup];
    
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

- (void) playButtonTapped {
    
    [Options playTapSound];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) nextpeerButtonTapped {
    
    [Options playTapSound];
    
    [Nextpeer launchDashboard];
}

- (void) shopButtonTapped {
    
    [Options playTapSound];
    
    CCScene *shopScene = [CCBReader loadAsScene:@"ShopMenu"];
    [[CCDirector sharedDirector] replaceScene:shopScene];
}

- (void) shopCoinsButtonTapped {
    [Options playTapSound];
    
    CCScene *shopCoinsScene = [CCBReader loadAsScene:@"ShopCoins"];
    [[CCDirector sharedDirector] replaceScene:shopCoinsScene];
}

- (void) optionsButtonTapped {
    
    [Options playTapSound];
    
    CCScene *optionsScene = [CCBReader loadAsScene:@"Options"];
    [[CCDirector sharedDirector] replaceScene:optionsScene];
}

@end
