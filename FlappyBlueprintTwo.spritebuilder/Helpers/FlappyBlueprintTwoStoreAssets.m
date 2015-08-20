//
//  FlappyBlueprintTwoStoreAssets.m
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

#import "FlappyBlueprintTwoStoreAssets.h"
#import "VirtualCategory.h"
#import "VirtualCurrency.h"
#import "VirtualGood.h"
#import "VirtualCurrencyPack.h"
#import "SingleUseVG.h"
#import "PurchaseWithMarket.h"
#import "PurchaseWithVirtualItem.h"
#import "MarketItem.h"
#import "LifetimeVG.h"
#import "EquippableVG.h"
#import "SingleUsePackVG.h"
#import "UpgradeVG.h"

#import "Defaults.h"

#import "PlistManager.h"

// Currencies
NSString* const COINS_CURRENCY_ITEM_ID = @"currency_coin";

// Goods
NSString* const CLOTHES_GOOD_01_ITEM_ID = @"clothes_good_01";
NSString* const CLOTHES_GOOD_02_ITEM_ID = @"clothes_good_02";
NSString* const CLOTHES_GOOD_03_ITEM_ID = @"clothes_good_03";
NSString* const CLOTHES_GOOD_04_ITEM_ID = @"clothes_good_04";
NSString* const CLOTHES_GOOD_05_ITEM_ID = @"clothes_good_05";
NSString* const CLOTHES_GOOD_06_ITEM_ID = @"clothes_good_06";
NSString* const CLOTHES_GOOD_07_ITEM_ID = @"clothes_good_07";
NSString* const CLOTHES_GOOD_08_ITEM_ID = @"clothes_good_08";
NSString* const CLOTHES_GOOD_09_ITEM_ID = @"clothes_good_09";

NSString* const HEAD_START_GOOD_ITEM_ID = @"head_start_good";
NSString* const SUPER_HEAD_START_GOOD_ITEM_ID = @"super_head_start_good";
NSString* const FINAL_BLAST_GOOD_ITEM_ID = @"final_blast_good";
NSString* const HEAD_START_PACK_GOOD_ITEM_ID = @"head_start_pack_good";
NSString* const SUPER_HEAD_START_PACK_GOOD_ITEM_ID = @"super_head_start_pack_good";
NSString* const FINAL_BLAST_PACK_GOOD_ITEM_ID = @"final_blast_pack_good";

NSString* const GADGETS_GOOD_01_ITEM_ID = @"less-pipes";
NSString* const GADGETS_GOOD_02_ITEM_ID = @"in_the_fog";
NSString* const GADGETS_GOOD_03_ITEM_ID = @"smoother_flyght";
NSString* const GADGETS_GOOD_04_ITEM_ID = @"reverse_gravity";
NSString* const GADGETS_GOOD_05_ITEM_ID = @"slower_speed";
NSString* const GADGETS_GOOD_06_ITEM_ID = @"random_gaps";
NSString* const GADGETS_GOOD_07_ITEM_ID = @"no_pipes";


// Currency Packs
NSString* const COIN_BOOSTER_PACK_ITEM_ID = @"coin_booster";
NSString* const COIN_MEGA_PACK_ITEM_ID = @"coin_mega";
NSString* const COIN_ULTRA_PACK_ITEM_ID = @"coin_ultra";
NSString* const COIN_IMPOSSIBLE_PACK_ITEM_ID = @"coin_impossible";
NSString* const COIN_ULTIMATE_PACK_ITEM_ID = @"coin_ultimate";

// Non Consumables
NSString* const X2_COINS_ITEM_ID = @"x2_coins";
NSString* const NO_ADS_ITEM_ID = @"no_ads";


@implementation FlappyBlueprintTwoStoreAssets

VirtualCategory* CLOTHES_CATEGORY;
VirtualCategory* BOOSTS_CATEGORY;
VirtualCategory* GADGETS_CATEGORY;
VirtualCategory* PACKS_OF_BOOSTS_CATEGORY;
VirtualCurrency* COINS_CURRENCY;
VirtualGood* HEAD_START_PACK_GOOD;
VirtualGood* SUPER_HEAD_START_PACK_GOOD;
VirtualGood* FINAL_BLAST_PACK_GOOD;
VirtualGood* HEAD_START_GOOD;
VirtualGood* SUPER_HEAD_START_GOOD;
VirtualGood* FINAL_BLAST_GOOD;
VirtualGood* CLOTHES_GOOD_01;
VirtualGood* CLOTHES_GOOD_02;
VirtualGood* CLOTHES_GOOD_03;
VirtualGood* CLOTHES_GOOD_04;
VirtualGood* CLOTHES_GOOD_05;
VirtualGood* CLOTHES_GOOD_06;
VirtualGood* CLOTHES_GOOD_07;
VirtualGood* CLOTHES_GOOD_08;
VirtualGood* CLOTHES_GOOD_09;
VirtualGood* GADGETS_GOOD_01;
VirtualGood* GADGETS_GOOD_02;
VirtualGood* GADGETS_GOOD_03;
VirtualGood* GADGETS_GOOD_04;
VirtualGood* GADGETS_GOOD_05;
VirtualGood* GADGETS_GOOD_06;
VirtualGood* GADGETS_GOOD_07;
VirtualCurrencyPack* COIN_BOOSTER_PACK;
VirtualCurrencyPack* COIN_MEGA_PACK;
VirtualCurrencyPack* COIN_ULTRA_PACK;
VirtualCurrencyPack* COIN_IMPOSSIBLE_PACK;
VirtualCurrencyPack* COIN_ULTIMATE_PACK;
VirtualGood* X2_COINS;
VirtualGood* NO_ADS;


+ (void)initialize{
    
    /** Virtual Currencies **/
    COINS_CURRENCY = [[VirtualCurrency alloc] initWithName:@"Coins" andDescription:@"" andItemId:COINS_CURRENCY_ITEM_ID];
    
    
    /** Virtual Currency Packs **/
    
    COIN_BOOSTER_PACK = [[VirtualCurrencyPack alloc] initWithName:@"Coin Booster Pack" andDescription:@"Coin booster pack." andItemId:COIN_BOOSTER_PACK_ITEM_ID andCurrencyAmount:COIN_BOOSTER_PACK_COINS_TO_GIVE andCurrency:COINS_CURRENCY_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinBoosterPackID] andConsumable:kConsumable andPrice:COIN_BOOSTER_PACK_PRICE]]];
    
    COIN_MEGA_PACK = [[VirtualCurrencyPack alloc] initWithName:@"Coin Mega Pack" andDescription:@"Coin mega pack." andItemId:COIN_MEGA_PACK_ITEM_ID andCurrencyAmount:COIN_MEGA_PACK_COINS_TO_GIVE andCurrency:COINS_CURRENCY_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinMegaPackID] andConsumable:kConsumable andPrice:COIN_MEGA_PACK_PRICE]]];
    
    COIN_ULTRA_PACK = [[VirtualCurrencyPack alloc] initWithName:@"Coin Ultra Pack" andDescription:@"Coin ultra pack." andItemId:COIN_ULTRA_PACK_ITEM_ID andCurrencyAmount:COIN_ULTRA_PACK_COINS_TO_GIVE andCurrency:COINS_CURRENCY_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinUltraPackID] andConsumable:kConsumable andPrice:COIN_ULTRA_PACK_PRICE]]];
    
    COIN_IMPOSSIBLE_PACK = [[VirtualCurrencyPack alloc] initWithName:@"Coin IMPOSSIBLE Pack" andDescription:@"Coin IMPOSSIBLE pack." andItemId:COIN_IMPOSSIBLE_PACK_ITEM_ID andCurrencyAmount:COIN_IMPOSSIBLE_PACK_COINS_TO_GIVE andCurrency:COINS_CURRENCY_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinImpossiblePackID] andConsumable:kConsumable andPrice:COIN_IMPOSSIBLE_PACK_PRICE]]];
    
    COIN_ULTIMATE_PACK = [[VirtualCurrencyPack alloc] initWithName:@"Coin Ultimate Pack" andDescription:@"Coin ultimate pack." andItemId:COIN_ULTIMATE_PACK_ITEM_ID andCurrencyAmount:COIN_ULTIMATE_PACK_COINS_TO_GIVE andCurrency:COINS_CURRENCY_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinUltimatePackID] andConsumable:kConsumable andPrice:COIN_ULTIMATE_PACK_PRICE]]];
    
    
    /** Virtual Goods **/
    
    /* SingleUseVGs */
    
    HEAD_START_GOOD = [[SingleUseVG alloc] initWithName:@"Head Start" andDescription:@"Head start." andItemId:HEAD_START_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_HEAD_START_PRICE]];
    
    SUPER_HEAD_START_GOOD = [[SingleUseVG alloc] initWithName:@"Super Head Start" andDescription:@"Super head start." andItemId:SUPER_HEAD_START_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_SUPER_HEAD_START_PRICE]];
    
    FINAL_BLAST_GOOD = [[SingleUseVG alloc] initWithName:@"Save Me" andDescription:@"Save me." andItemId:FINAL_BLAST_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_FINAL_BLAST_PRICE]];
    
    /* EquippableVGs */
    
        /* SingleUsePackVGs */
    
    // clothes
    CLOTHES_GOOD_01 = [[EquippableVG alloc] initWithName:@"Clothes Good 01" andDescription:@"Clothes good 01." andItemId:CLOTHES_GOOD_01_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_01_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_02 = [[EquippableVG alloc] initWithName:@"Clothes Good 02" andDescription:@"Clothes good 02." andItemId:CLOTHES_GOOD_02_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_02_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_03 = [[EquippableVG alloc] initWithName:@"Clothes Good 03" andDescription:@"Clothes good 03." andItemId:CLOTHES_GOOD_03_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_03_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_04 = [[EquippableVG alloc] initWithName:@"Clothes Good 04" andDescription:@"Clothes good 04." andItemId:CLOTHES_GOOD_04_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_04_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_05 = [[EquippableVG alloc] initWithName:@"Clothes Good 05" andDescription:@"Clothes good 05." andItemId:CLOTHES_GOOD_05_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_05_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_06 = [[EquippableVG alloc] initWithName:@"Clothes Good 06" andDescription:@"Clothes good 06." andItemId:CLOTHES_GOOD_06_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_06_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_07 = [[EquippableVG alloc] initWithName:@"Clothes Good 07" andDescription:@"Clothes good 07." andItemId:CLOTHES_GOOD_07_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_07_PRICE] andEquippingModel:kCategory];
    
    CLOTHES_GOOD_08 = [[EquippableVG alloc] initWithName:@"Clothes Good 08" andDescription:@"Clothes good 08." andItemId:CLOTHES_GOOD_08_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_08_PRICE] andEquippingModel:kCategory];
    CLOTHES_GOOD_09 = [[EquippableVG alloc] initWithName:@"Clothes Good 09" andDescription:@"Clothes good 09." andItemId:CLOTHES_GOOD_09_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:CLOTHES_PRODUCT_09_PRICE] andEquippingModel:kCategory];

    
    HEAD_START_PACK_GOOD = [[SingleUsePackVG alloc] initWithName:@"Head Start Pack" andDescription:@"Head start pack." andItemId:HEAD_START_PACK_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_HEAD_START_PACK_PRICE] andSingleUseGood:HEAD_START_GOOD_ITEM_ID andAmount:HEAD_STARTS_TO_GIVE_IN_PACK];
    
    SUPER_HEAD_START_PACK_GOOD = [[SingleUsePackVG alloc] initWithName:@"Super Head Start Pack" andDescription:@"Super head start pack." andItemId:SUPER_HEAD_START_PACK_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_SUPER_HEAD_START_PACK_PRICE] andSingleUseGood:SUPER_HEAD_START_GOOD_ITEM_ID andAmount:SUPER_HEAD_STARTS_TO_GIVE_IN_PACK];
    
    FINAL_BLAST_PACK_GOOD = [[SingleUsePackVG alloc] initWithName:@"Save Me Pack" andDescription:@"Save me pack." andItemId:FINAL_BLAST_PACK_GOOD_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:BOOSTS_SUPER_HEAD_START_PACK_PRICE] andSingleUseGood:FINAL_BLAST_GOOD_ITEM_ID andAmount:FINAL_BLASTS_TO_GIVE_IN_PACK];
    
    // gadgets
    GADGETS_GOOD_01 = [[EquippableVG alloc] initWithName:@"Gadgets Good 01" andDescription:@"Gadgets good 01." andItemId:GADGETS_GOOD_01_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_01_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_02 = [[EquippableVG alloc] initWithName:@"Gadgets Good 02" andDescription:@"Gadgets good 02." andItemId:GADGETS_GOOD_02_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_02_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_03 = [[EquippableVG alloc] initWithName:@"Gadgets Good 03" andDescription:@"Gadgets good 03." andItemId:GADGETS_GOOD_03_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_03_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_04 = [[EquippableVG alloc] initWithName:@"Gadgets Good 04" andDescription:@"Gadgets good 04." andItemId:GADGETS_GOOD_04_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_04_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_05 = [[EquippableVG alloc] initWithName:@"Gadgets Good 05" andDescription:@"Gadgets good 05." andItemId:GADGETS_GOOD_05_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_05_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_06 = [[EquippableVG alloc] initWithName:@"Gadgets Good 06" andDescription:@"Gadgets good 06." andItemId:GADGETS_GOOD_06_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_06_PRICE] andEquippingModel:kCategory];
    
    GADGETS_GOOD_07 = [[EquippableVG alloc] initWithName:@"Gadgets Good 07" andDescription:@"Gadgets good 07." andItemId:GADGETS_GOOD_07_ITEM_ID andPurchaseType:[[PurchaseWithVirtualItem alloc] initWithVirtualItem:COINS_CURRENCY_ITEM_ID andAmount:GADGETS_PRODUCT_07_PRICE] andEquippingModel:kCategory];
    
    /** Virtual Categories **/
    
    BOOSTS_CATEGORY  = [[VirtualCategory alloc] initWithName:@"Boosts" andGoodsItemIds:@[HEAD_START_GOOD_ITEM_ID, SUPER_HEAD_START_GOOD_ITEM_ID, FINAL_BLAST_GOOD_ITEM_ID]];
    
    CLOTHES_CATEGORY  = [[VirtualCategory alloc] initWithName:@"Clothes" andGoodsItemIds:@[CLOTHES_GOOD_01_ITEM_ID, CLOTHES_GOOD_02_ITEM_ID, CLOTHES_GOOD_03_ITEM_ID, CLOTHES_GOOD_04_ITEM_ID, CLOTHES_GOOD_05_ITEM_ID, CLOTHES_GOOD_06_ITEM_ID, CLOTHES_GOOD_07_ITEM_ID, CLOTHES_GOOD_08_ITEM_ID, CLOTHES_GOOD_09_ITEM_ID]];
    
    GADGETS_CATEGORY  = [[VirtualCategory alloc] initWithName:@"Gadgets" andGoodsItemIds:@[GADGETS_GOOD_01_ITEM_ID, GADGETS_GOOD_02_ITEM_ID, GADGETS_GOOD_03_ITEM_ID, GADGETS_GOOD_04_ITEM_ID, GADGETS_GOOD_05_ITEM_ID, GADGETS_GOOD_06_ITEM_ID, GADGETS_GOOD_07_ITEM_ID]];
    
    PACKS_OF_BOOSTS_CATEGORY  = [[VirtualCategory alloc] initWithName:@"Packs of BOOSTS" andGoodsItemIds:@[HEAD_START_PACK_GOOD_ITEM_ID, SUPER_HEAD_START_PACK_GOOD_ITEM_ID, FINAL_BLAST_PACK_GOOD_ITEM_ID]];
    
    
    /** Lifetime VGs **/
    
    X2_COINS = [[LifetimeVG alloc] initWithName:@"X2 Coins" andDescription:@"X2 coins." andItemId:X2_COINS_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPDoubleCoinsID] andConsumable:kConsumable andPrice:X2_COINS_PRICE]]];
    
    NO_ADS = [[LifetimeVG alloc] initWithName:@"No Ads" andDescription:@"No more ads." andItemId:NO_ADS_ITEM_ID andPurchaseType:[[PurchaseWithMarket alloc] initWithMarketItem:[[MarketItem alloc] initWithProductId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPNoAdsID] andConsumable:kConsumable andPrice:NO_ADS_PRICE]]];
    
}

- (int)getVersion {
    return 0;
}

- (NSArray*)virtualCurrencies{
    return @[COINS_CURRENCY];
}

- (NSArray*)virtualGoods{
    return @[
             /* SingleUseVGs     --> */ HEAD_START_GOOD, SUPER_HEAD_START_GOOD, FINAL_BLAST_GOOD,
             /* EquippableVGs    --> */ CLOTHES_GOOD_01, CLOTHES_GOOD_02, CLOTHES_GOOD_03, CLOTHES_GOOD_04, CLOTHES_GOOD_05, CLOTHES_GOOD_06, CLOTHES_GOOD_07, CLOTHES_GOOD_08, CLOTHES_GOOD_09, GADGETS_GOOD_01, GADGETS_GOOD_02, GADGETS_GOOD_03, GADGETS_GOOD_04, GADGETS_GOOD_05, GADGETS_GOOD_06, GADGETS_GOOD_07,
             /* SingleUsePackVGs --> */ HEAD_START_PACK_GOOD, SUPER_HEAD_START_PACK_GOOD, FINAL_BLAST_PACK_GOOD,
             /* LifetimeVGs --> */ X2_COINS, NO_ADS
                                        ];
}

- (NSArray*)virtualCurrencyPacks{
    return @[COIN_BOOSTER_PACK, COIN_MEGA_PACK, COIN_ULTRA_PACK, COIN_IMPOSSIBLE_PACK, COIN_ULTIMATE_PACK];
}

- (NSArray*)virtualCategories{
    return @[CLOTHES_CATEGORY, BOOSTS_CATEGORY, PACKS_OF_BOOSTS_CATEGORY, GADGETS_CATEGORY];
}

@end
