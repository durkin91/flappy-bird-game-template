//
//  AdvancedSettings.h
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

#ifndef FlappyBlueprintTwo_AdvancedSettings_h
#define FlappyBlueprintTwo_AdvancedSettings_h

//---------------------------------------------------------------------------
/*
 * Notes
 */

static BOOL const USE_NOTES = NO;
static int const NUMBER_OF_HEARTS_BETWEEN_NOTES = 1;
static int const MAXIMUM_NOTE_NUMBER = 10;

//---------------------------------------------------------------------------
/*
 * Gameplay speed
 */

static float const SCROLL_SPEED_NORMAL = 150;
static float const SCROLL_SPEED_GADGET_05 = 90;

//---------------------------------------------------------------------------
/*
 * Distance between pipes
 */

static float const DISTANCE_BETWEEN_PIPES_GADGET_01 = 400;

static float const DISTANCE_BETWEEN_PIPES_EASY = 360;
static float const DISTANCE_BETWEEN_PIPES_MEDIUM = 260;
static float const DISTANCE_BETWEEN_PIPES_HARD = 200;

//---------------------------------------------------------------------------
/*
 * Gap distance between pipes
 */

static float const PIPE_DISTANCE_EASY = 160;
static float const PIPE_DISTANCE_MEDIUM = 120;
static float const PIPE_DISTANCE_HARD = 120;


//---------------------------------------------------------------------------
/*
 * The position of the first obstacle
 */

static const CGFloat firstObstaclePosition = 280.f;

//---------------------------------------------------------------------------
/*
 * Use random pipes or use yust one pipe set (PipeBottom01.png & PipeTop01.png)
 */

static BOOL const USE_RANDOM_PIPES = NO;

//---------------------------------------------------------------------------
/*
 * IAP Prices
 *
 * You don't have to if you don't want to, but it is advised to dive your
 * IAP products the following prices when setting them up in iTune Connect.
 * If you have given another price, please change them below accordingly:
 * (this information will be shown in your shop coins view)
 */

static float const COIN_BOOSTER_PACK_PRICE = 1.99;
static float const COIN_MEGA_PACK_PRICE = 3.99;
static float const COIN_ULTRA_PACK_PRICE = 5.99;
static float const COIN_IMPOSSIBLE_PACK_PRICE = 9.99;
static float const COIN_ULTIMATE_PACK_PRICE = 29.99;
static float const X2_COINS_PRICE = 4.99;
static float const NO_ADS_PRICE = 1.99;

//---------------------------------------------------------------------------
/*
 * Pack Coins
 *
 * Set the amount of coins the user will get when purchasing a coins pack:
 * (Think twice befor you change these!)
 */

static NSInteger const COIN_BOOSTER_PACK_COINS_TO_GIVE = 200;
static NSInteger const COIN_MEGA_PACK_COINS_TO_GIVE = 500;
static NSInteger const COIN_ULTRA_PACK_COINS_TO_GIVE = 1000;
static NSInteger const COIN_IMPOSSIBLE_PACK_COINS_TO_GIVE = 2500;
static NSInteger const COIN_ULTIMATE_PACK_COINS_TO_GIVE = 10000;

//---------------------------------------------------------------------------
/*
 * First app launch
 *
 * Set the amount of coins a user will get when first starting the game.
 * This amount will be given only once.
 */

static NSInteger const COINS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH = 1000;
static NSInteger const HEAD_STARTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH = 3;
static NSInteger const SUPER_HEAD_STARTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH = 3;
static NSInteger const FINAL_BLASTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH = 5;

//---------------------------------------------------------------------------

/*
 * Testing First Launch
 *
 * Set this to YES when testing first launch in SIMULATOR
 *
 * IMPORTANT: This is not needed when testing on a real device, so set it to NO.
 *
 */

#warning MAKE SURE YOU SET "RESET_FIRTS_LAUNCH_OPTIONS" TO "NO" BEFORE SUBMITTING FOR APPLE REVIEW. OTHERWISE DON'T WORRY ABOUT THIS WARNING, IT'S JUST A REMINDER.
static BOOL const RESET_FIRTS_LAUNCH_OPTIONS = NO;

//---------------------------------------------------------------------------
/*
 * Virtual Goods Prices
 *
 * Set the amount of coins a user will pay when purchasing a virtual good:
 * (Think twice befor you change these!)
 */

/*
 * Clothes/ characters
 */

static NSInteger const CLOTHES_PRODUCT_01_PRICE = 15;
static NSInteger const CLOTHES_PRODUCT_02_PRICE = 30;
static NSInteger const CLOTHES_PRODUCT_03_PRICE = 40;
static NSInteger const CLOTHES_PRODUCT_04_PRICE = 45;
static NSInteger const CLOTHES_PRODUCT_05_PRICE = 50;
static NSInteger const CLOTHES_PRODUCT_06_PRICE = 85;
static NSInteger const CLOTHES_PRODUCT_07_PRICE = 100;
static NSInteger const CLOTHES_PRODUCT_08_PRICE = 115;
static NSInteger const CLOTHES_PRODUCT_09_PRICE = 150;

//---------------------------------------------------------------------------
/*
 * Boosts prices
 *
 * Set the prices in coins of the boosts.
 */

static NSInteger const BOOSTS_HEAD_START_PRICE = 5;
static NSInteger const BOOSTS_SUPER_HEAD_START_PRICE = 10;
static NSInteger const BOOSTS_FINAL_BLAST_PRICE = 10;
static NSInteger const BOOSTS_HEAD_START_PACK_PRICE = 20;
static NSInteger const BOOSTS_SUPER_HEAD_START_PACK_PRICE = 40;
static NSInteger const BOOSTS_FINAL_BLAST_PACK_PRICE = 40;

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/*
 * Gadgets
 */

static NSInteger const GADGETS_PRODUCT_01_PRICE = 60;
static NSInteger const GADGETS_PRODUCT_02_PRICE = 100;
static NSInteger const GADGETS_PRODUCT_03_PRICE = 300;
static NSInteger const GADGETS_PRODUCT_04_PRICE = 1000;
static NSInteger const GADGETS_PRODUCT_05_PRICE = 3600;
static NSInteger const GADGETS_PRODUCT_06_PRICE = 7000;
static NSInteger const GADGETS_PRODUCT_07_PRICE = 10000;

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/*
 * Item numbers in packs
 *
 * Set the number of items a boost has.
 */

static NSInteger const HEAD_STARTS_TO_GIVE_IN_PACK = 5;
static NSInteger const SUPER_HEAD_STARTS_TO_GIVE_IN_PACK = 5;
static NSInteger const FINAL_BLASTS_TO_GIVE_IN_PACK = 5;

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/*
 * Play On Price.
 *
 * This is the amount the user has to pay if he wants to continue the game
 * from where he died.
 *
 */

static NSInteger const PLAY_ON_PRICE = 10;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
 * Your Virtual Currency Name
 *
 * This could be anything that the user collects/spends during the game.
 * e.g. "coins", "gems", "lights", "stars"
 *
 * make this one all lower case and in plural
 */

#define VIRTUAL_CURRENCY_NAME @"coins"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
 * ALERTS
 *
 * Insuficient funds alert.
 *
 * This is called whenever your user wants to buy some virtual good, but s/he
 * doesn't have enough of the virtual currency (coins).
 */

#define INSUFICIENT_FUNDS_ALERT_TITLE @"Insufficient funds"
#define INSUFICIENT_FUNDS_ALERT_DESCRIPTION @"You don't have enough coins to purchase this item. Would you like to buy some more coins?"
#define INSUFICIENT_FUNDS_ALERT_YES_BUTTON @"Buy now!"
#define INSUFICIENT_FUNDS_ALERT_NO_BUTTON @"No, thanks"

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/*
 * ALERTS
 *
 * Confirm purchase alert.
 *
 * This is called whenever a user taps on the "Buy" button of a virtal good.
 */
//not used by Done
#define CONFIRM_PURCHASE_ALERT_TITLE @"Confirm Your Purchase"
#define CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART @"Do you want to buy"

#define CONFIRM_PURCHASE_ALERT_CHARACTER_01_NAME @"Character One"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_02_NAME @"Character Two"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_03_NAME @"Character Three"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_04_NAME @"Character Four"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_05_NAME @"Character Five"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_06_NAME @"Character Six"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_07_NAME @"Character Seven"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_08_NAME @"Character Eight"
#define CONFIRM_PURCHASE_ALERT_CHARACTER_RANDOM_NAME @"Random Character"


#define CONFIRM_PURCHASE_ALERT_HEAD_START_NAME @"Head Start"
#define CONFIRM_PURCHASE_ALERT_SUPER_HEAD_START_NAME @"Super Head Start"
#define CONFIRM_PURCHASE_ALERT_SAVE_ME_NAME @"Final Blast"
#define CONFIRM_PURCHASE_ALERT_HEAD_START_PACK_NAME @"Head Start Pack"
#define CONFIRM_PURCHASE_ALERT_SUPER_HEAD_START_PACK_NAME @"Super Head Start Pack"
#define CONFIRM_PURCHASE_ALERT_SAVE_ME_PACK_NAME @"Final Blast Pack"

#define CONFIRM_PURCHASE_ALERT_GADGET_01_NAME @"Less Pipes"
#define CONFIRM_PURCHASE_ALERT_GADGET_02_NAME @"In The Fog"
#define CONFIRM_PURCHASE_ALERT_GADGET_03_NAME @"Smoother Flight"
#define CONFIRM_PURCHASE_ALERT_GADGET_04_NAME @"Reverse Gravity"
#define CONFIRM_PURCHASE_ALERT_GADGET_05_NAME @"Slower Speed"
#define CONFIRM_PURCHASE_ALERT_GADGET_06_NAME @"Random Gaps"
#define CONFIRM_PURCHASE_ALERT_GADGET_07_NAME @"No Pipes"
#define CONFIRM_PURCHASE_ALERT_REMOVE_GADGET_NAME @"Remove Gadget"

// the rest of the message varies according to the product
// it will look something like this: "Do you want to buy one Head Start for 2000 coins?"

#define CONFIRM_PURCHASE_ALERT_YES_BUTTON @"Buy now!"
#define CONFIRM_PURCHASE_ALERT_NO_BUTTON @"Cancel"

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/*
 * ALERTS
 *
 * Confirm equip alert.
 *
 * This is called whenever a user taps on the "Buy" button of a virtal good.
 */
//not used by Done
#define CONFIRM_EQUIP_ALERT_TITLE @"Confirm Equipping"
#define CONFIRM_REMOVE_GADGET_ALERT_TITLE @"Confirm Removing of Gadget"
#define CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART @"Do you want to equip the"
#define CONFIRM_REMOVE_GADGET_MESSAGE @"Do you want to remove the current gadget?"

// the rest of the message varies according to the product
// it will look something like this: "Do you want to buy one Head Start for 2000 coins?"

#define CONFIRM_EQUIP_ALERT_YES_BUTTON @"Yes, equip!"
#define CONFIRM_REMOVE_GADGET_ALERT_YES_BUTTON @"Yes, remove!"
#define CONFIRM_EQUIP_ALERT_NO_BUTTON @"Cancel"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
 * Share text.
 *
 * This is called whenever a user taps on the "Share" button.
 */

#define SHARE_TEXT_FIRST_PART @"OMG ! I scored"
#define SHARE_TEXT_SECOND_PART @"points in Flappy Blueprint Two !"
#define SHARE_TEXT_THIRD_PART @"Download Flappy Blueprint Two now !"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
 * Boosts lasting time
 */

static NSInteger const SECONDS_FOR_HEAD_START = 10;
static NSInteger const SECONDS_FOR_SUPER_HEAD_START = 25;


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*****************************************
 ********** LOCAL NOTIFICATIONS **********
 *****************************************
 */

/*
 * Set up your texts here:
 */

#define LOCAL_NOTIFICATION_TEXT_01 @"Hey, come back. Your Blueprint2 is waiting for you!"
#define LOCAL_NOTIFICATION_TEXT_02 @"Does a bird scare you?"
#define LOCAL_NOTIFICATION_TEXT_03 @"Think of a thing... Was it a bird?"
#define LOCAL_NOTIFICATION_TEXT_04 @"Hmm... Birds are good."
#define LOCAL_NOTIFICATION_TEXT_05 @"It's Flappy time!"
#define LOCAL_NOTIFICATION_TEXT_06 @"I know you wanna play with me."
#define LOCAL_NOTIFICATION_TEXT_07 @"Avoid some more pipes..."
#define LOCAL_NOTIFICATION_TEXT_08 @"We like birds. Do you?"
#define LOCAL_NOTIFICATION_TEXT_09 @"Can you beat your own best score now?"
#define LOCAL_NOTIFICATION_TEXT_10 @"We miss you. Come back and play Flappy Blueprint Two."

/*
 * Set up your time interval.
 *
 * Measured in seconds.
 *
 * 1 day = 86400
 * 2 days = 172800
 * 3 days = 259200
 * 1 week = 604800
 *
 * Of course you may set it to any time interval, like 30 seconds for testing.
 * Now it's set to 600 seconds.
 *
 * Note: The timer is triggered when the user exits the app.
 */

static NSUInteger const LOCAL_PUSH_NOTIFICATION_TIME_TO_WAIT = 600;

//---------------------------------------------------------------------------

#endif
