//
//  ShopMenu.m
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

#import "ShopMenu.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "Options.h"
#import "Flurry.h"

@implementation ShopMenu {
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

- (void) shopCharactersTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Menu] Shop Characters button tapped."];
    [Options playTapSound];
    
    CCScene *shopCharactersScene = [CCBReader loadAsScene:@"ShopCharacters"];
    [[CCDirector sharedDirector] replaceScene:shopCharactersScene];
}

- (void) shopBoostsTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Menu] Shop Boosts button tapped."];
    [Options playTapSound];
    
    CCScene *shopBoostsScene = [CCBReader loadAsScene:@"ShopBoosts"];
    [[CCDirector sharedDirector] replaceScene:shopBoostsScene];
}

- (void) shopGadgetsTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Menu] Shop Gadgets button tapped."];
    [Options playTapSound];
    
    CCScene *shopGadgetsScene = [CCBReader loadAsScene:@"ShopGadgets"];
    [[CCDirector sharedDirector] replaceScene:shopGadgetsScene];
}

- (void) shopCoinsTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Menu] Shop Coins button tapped."];
    [Options playTapSound];
    
    CCScene *shopCoinsScene = [CCBReader loadAsScene:@"ShopCoins"];
    [[CCDirector sharedDirector] replaceScene:shopCoinsScene];
}

- (void) backButtonTapped {
    [Options playTapSound];
    
    CCScene *mainMenuScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
}

@end
