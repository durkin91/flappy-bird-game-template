//
//  ShopCoins.m
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

#import "ShopCoins.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "SoomlaStore.h"
#import "Options.h"
#import "Flurry.h"

@implementation ShopCoins

- (void) coin01Tapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy 200 button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy coin booster button tapped.");
    [StoreInventory buyItemWithItemId:COIN_BOOSTER_PACK_ITEM_ID andPayload:@"booster"];

}

- (void) coin02Tapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy 500 button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy life mega button tapped.");
    [StoreInventory buyItemWithItemId:COIN_MEGA_PACK_ITEM_ID andPayload:@"mega"];
}

- (void) coin03Tapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy 1000 button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy life ultra button tapped.");
    [StoreInventory buyItemWithItemId:COIN_ULTRA_PACK_ITEM_ID andPayload:@"ultra"];
}

- (void) coin04Tapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy 2500 button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy life dots button tapped.");
    [StoreInventory buyItemWithItemId:COIN_IMPOSSIBLE_PACK_ITEM_ID andPayload:@"impossible"];
}

- (void) coin05Tapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy 10000 button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy life ultimate button tapped.");
    [StoreInventory buyItemWithItemId:COIN_ULTIMATE_PACK_ITEM_ID andPayload:@"ultimate"];
}

- (void) noAdsTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy No Ads button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy no ads button tapped.");
    [StoreInventory buyItemWithItemId:NO_ADS_ITEM_ID andPayload:@"noAds"];
}

- (void) doubleCoinsTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy Double Coins button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Buy double coins button tapped.");
    [StoreInventory buyItemWithItemId:X2_COINS_ITEM_ID andPayload:@"x2"];
}

- (void) restorePurchasesTapped {
    // FLURRY LOG
    [Flurry logEvent:@"[Shop Coins] Buy Restore button tapped."];
    
    [Options playTapSound];
    
    NSLog(@"Restore purchases button tapped.");
    [[SoomlaStore getInstance] restoreTransactions];
}


- (void) backButtonTapped {
    [Options playTapSound];
    
    CCScene *shopScene = [CCBReader loadAsScene:@"ShopMenu"];
    [[CCDirector sharedDirector] replaceScene:shopScene];
}

@end
