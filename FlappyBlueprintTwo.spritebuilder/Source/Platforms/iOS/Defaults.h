//
//  Defaults.h
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

#import "AdvancedSettings.h"

#ifndef FlappyBlueprintTwo_Defaults_h
#define FlappyBlueprintTwo_Defaults_h

    ///////////////////////////////////
    // PLEASE DO NOT TOUCH THESE !!! //
    ///////////////////////////////////

#define kCountStartup @"CountStartup"
#define kCountGameOver @"CountGameOver"

//NSString *settingsName;
//NSString *settingsNamePlist;
//NSMutableArray *settingsArray;

#define settingsName @"FlappyBlueprintTwoSettings"
#define settingsNamePlist @"FlappyBlueprintTwoSettings.plist"

#define kXLink @"XLink"
#define kXLinkPleaseDoNotEverChangeMeString @"PLEASE_DO_NOT_EVER_CHANGE_ME"

#define kCheckboxYes @"YES"
#define kCheckboxNo @"NO"

#define kSoomlaCustomSecret @"Soomla Custom Secret"
#define kSoomlaIAPCoinBoosterPackID @"Soomla IAP Coin Booster Pack ID"
#define kSoomlaIAPCoinMegaPackID @"Soomla IAP Coin Mega Pack ID"
#define kSoomlaIAPCoinUltraPackID @"Soomla IAP Coin Ultra Pack ID"
#define kSoomlaIAPCoinImpossiblePackID @"Soomla IAP Coin Impossible Pack ID"
#define kSoomlaIAPCoinUltimatePackID @"Soomla IAP Coin Ultimate Pack ID"
#define kSoomlaIAPDoubleCoinsID @"Soomla IAP Double Coins ID"
#define kSoomlaIAPNoAdsID @"Soomla IAP No Ads ID"

#define kAdsFrequencyStartup @"Ads Frequency Startup"
#define kAdsFrequencyGameOver @"Ads Frequency Game Over"

//NSString *CUSTOM_SECRET;
//NSString *COIN_BOOSTER_PACK_IAP_ID;
//NSString *COIN_MEGA_PACK_IAP_ID;
//NSString *COIN_ULTRA_PACK_IAP_ID;
//NSString *COIN_IMPOSSIBLE_PACK_IAP_ID;
//NSString *COIN_ULTIMATE_PACK_IAP_ID;
//NSString *X2_COINS_IAP_ID;
//NSString *NO_ADS_IAP_ID;

//NSString *CHARTBOOST_APP_ID;
//NSString *CHARTBOOST_APP_SIGNATURE;
//BOOL SHOW_CHARTBOOST_INTERSTITIAL_AT_STARTUP;
//BOOL SHOW_CHARTBOOST_INTERSTITIAL_AT_GAME_OVER;

//NSString *REVMOB_APP_ID;
//BOOL SHOW_REVMOB_INTERSTITIAL_AT_STARTUP;
//BOOL SHOW_REVMOB_INTERSTITIAL_AT_GAME_OVER;
//NSString *REVMOB_INTERSTITIAL_AT_STARTUP_PLACEMENT_ID;
//NSString *REVMOB_INTERSTITIAL_AT_GAME_OVER_PLACEMENT_ID;

//NSString *VUNGLE_APP_ID;
//BOOL SHOW_VUNGLE_AD_AT_STARTUP;
//BOOL SHOW_VUNGLE_AD_AT_GAME_OVER;

//NSString *GC_LEADERBOARD;

//NSString *FLURRY_API_KEY;

//int ADS_FREQUENCY_STARTUP;
//int ADS_FREQUENCY_GAME_OVER;

//NSString *NEXTPEER_GAME_KEY;


// sound on off key
#define kFXState @"FXState"

#define NOTIFICATION_START_MULTIPLAYER @"startMultiPlayerGame"

#define IS_BOOST_ACTIVE @"IS_BOOST_ACTIVE"
#define IS_SUPER_BOOST_ACTIVE @"IS_SUPER_BOOST_ACTIVE"

// Game difficulty
#define GAME_DIFFICULTY @"Game Difficulty"

#define kEASY_DIFFICULTY @"Easy"
#define kMEDIUM_DIFFICULTY @"Medium"
#define kHARD_DIFFICULTY @"Hard"


//Notes
#define NOTE_NUMBER_KEY @"Note Number Key"
#define NOTE_MESSAGE_KEY @"Note Message Key"
#define NOTES_DATA @"Notes Data"
#define NOTES_AWAITING_DISPLAY @"Notes Awaiting Display"
#define NOTES_ALREADY_VIEWED @"Notes Already Viewed"

/*
typedef NS_ENUM(NSInteger, HeroType) {
    kHeroType01,
    kHeroType02,
    kHeroType03,
    kHeroType04,
    kHeroType05,
    kHeroType06,
    kHeroType07,
    kHeroType08,
    kHeroTypeRandom
    
};*/

#define heroType @"heroType"

typedef NS_ENUM(NSInteger, GadgetType) {
    kGadgetType01,
    kGadgetType02,
    kGadgetType03,
    kGadgetType04,
    kGadgetType05,
    kGadgetType06,
    kGadgetType07
    
};

typedef NS_ENUM(NSInteger, GameplayZeeOrder) {
    GameplayZeeOrderPhysicsNodeCity,
    GameplayZeeOrderScore,
    GameplayZeeOrderPhysicsNode,
    GameplayZeeOrderFog,
    GameplayZeeOrderCoinsCount,
    GameplayZeeOrderContinuePanel,
    GameplayZeeOrderContinuePanelButton,
};

typedef NS_ENUM(NSInteger, DrawingOrder) {
    DrawingOrderScore,
    DrawingOrderPipes,
    DrawingOrderGround,
    DrawingOrderHero
    
};

typedef NS_ENUM(NSInteger, GameOverZeeOrder) {
    GameOverZeeOrderPanel,
    GameOverZeeOrderNewBest,
    GameOverZeeOrderBestScore
    
};

#define isNewBestScore @"isNewBestScore"

#define theCurrentScore @"theCurrentScore"
#define theCurrentCoins @"theCurrentCoins"

#endif
