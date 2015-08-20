/*
 * SpriteBuilder: http://www.spritebuilder.org
 *
 * Copyright (c) 2012 Zynga Inc.
 * Copyright (c) 2013 Apportable Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "cocos2d.h"

#import "AppDelegate.h"
#import "CCBuilderReader.h"

#import "Score.h"
#import "Defaults.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "StoreEventHandling.h"
#import "StoreInventory.h"
#import "Soomla.h"
#import "SoomlaStore.h"
#import "PlistManager.h"
#import "ProgressHUD.h"
#import "RootViewControllerInterface.h"
#import "GameCenterManager.h"
#import "Nextpeer/Nextpeer.h"
#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import <RevMobAds/RevMobAds.h>
#import <VungleSDK/VungleSDK.h>
#import "iRate.h"
#import "Options.h"
#import "Flurry.h"

@interface AppController () <GameCenterManagerDelegate, NextpeerDelegate, NPTournamentDelegate, ChartboostDelegate, CBNewsfeedDelegate, VungleSDKDelegate>
@end

@implementation AppController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  // setting up my sfuff
  // order is important
  
  // setup plist file data
  [self setupPlistFileData];
  
  // setup store
  id<IStoreAssets> storeAssets = [[FlappyBlueprintTwoStoreAssets alloc] init];
  [Soomla initializeWithSecret:[PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaCustomSecret]];
  [[SoomlaStore getInstance] initializeWithStoreAssets:storeAssets];
  
  // setup Chartboost
  [self setupChartboost];
  
  // setup RevMob
  [self setupRevMob];
  
  //set sound ON
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFXState];
  
  
  // setup iRate
  [self setupiRate];
  
  // setup Vungle
  [self setupVungle];
  
  // initialize Nextpeer
  [self initializeNextpeer];
  
  // running setup of third party libs asynchronously on background thread
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    [self setupAppWithThirdPartyLibs];
    
    /*
     // showing something on main thread
     dispatch_async(dispatch_get_main_queue(), ^{
     
     });*/
  });

  
    // Configure Cocos2d with the options set in SpriteBuilder
    NSString* configPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"]; // TODO: add support for Published-Android support
    configPath = [configPath stringByAppendingPathComponent:@"configCocos2d.plist"];
    
    NSMutableDictionary* cocos2dSetup = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    
    // Note: this needs to happen before configureCCFileUtils is called, because we need apportable to correctly setup the screen scale factor.
#ifdef APPORTABLE
    if([cocos2dSetup[CCSetupScreenMode] isEqual:CCScreenModeFixed])
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenAspectFitEmulationMode];
    else
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenScaledAspectFitEmulationMode];
#endif
    
    // Configure CCFileUtils to work with SpriteBuilder
    [CCBReader configureCCFileUtils];
    
    // Do any extra configuration of Cocos2d here (the example line changes the pixel format for faster rendering, but with less colors)
    //[cocos2dSetup setObject:kEAGLColorFormatRGB565 forKey:CCConfigPixelFormat];
    
    [self setupCocos2dWithOptions:cocos2dSetup];
  
  // Add the viewController to the RootViewControllerInterface.
  // needs to be set here !!!
  [[RootViewControllerInterface sharedManager] setRootViewController:window_.rootViewController];
  
  // delete remaining screenshots if any
  [AppController deleteScreenshot];
  
  // asking for permission for local notification
  if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
  }
  // setting badge number to 0
  application.applicationIconBadgeNumber = 0;
  // setting up and scheduling local notification
  [self setupLocalNotifications];
  
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  application.applicationIconBadgeNumber = 0;
}

- (CCScene*) startScene
{
    return [CCBReader loadAsScene:@"MainMenu"];
}

- (void) setupLocalNotifications {
  
  int randomNotification = arc4random() % 10;
  NSString *notificationMessage;
  
  switch (randomNotification) {
    case 0:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_01;
      break;
    case 1:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_02;
      break;
    case 2:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_03;
      break;
    case 3:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_04;
      break;
    case 4:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_05;
      break;
    case 5:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_05;
      break;
    case 6:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_07;
      break;
    case 7:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_08;
      break;
    case 8:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_09;
      break;
    case 9:
      notificationMessage = LOCAL_NOTIFICATION_TEXT_10;
      break;
      
    default:
      break;
  }
  
  localNotification = [[UILocalNotification alloc] init];
  localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:LOCAL_PUSH_NOTIFICATION_TIME_TO_WAIT];
  localNotification.alertBody = notificationMessage;
  localNotification.soundName = UILocalNotificationDefaultSoundName;
  localNotification.applicationIconBadgeNumber++;
  localNotification.timeZone = [NSTimeZone defaultTimeZone];
  // canceling all current notifications
  [[UIApplication sharedApplication] cancelAllLocalNotifications];
  // scheduling new notification
  [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


- (void) setupAppWithThirdPartyLibs {
  
  // notification observers
  
  // notification observer for multiplayer Nextpeer game launch
  [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(startMultiPlayerGame:) name: NOTIFICATION_START_MULTIPLAYER object: nil];
  
  // store
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodBalanceChanged) name:EVENT_GOOD_BALANCE_CHANGED object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertUnexpectedErrorInStore) name:EVENT_UNEXPECTED_ERROR_IN_STORE object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTransactionRestoreStarted) name:EVENT_RESTORE_TRANSACTIONS_STARTED object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTransactionRestoreFinished) name:EVENT_RESTORE_TRANSACTIONS_FINISHED object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAppStorePurchaseStarted) name:EVENT_MARKET_PURCHASE_STARTED object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAppStorePurchased) name:EVENT_MARKET_PURCHASED object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAppStorePurchaseCanceled) name:EVENT_MARKET_PURCHASE_CANCELLED object:nil];
  
  if (RESET_FIRTS_LAUNCH_OPTIONS) {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
  
  // determining first launch
  if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
  {
    // app already launched
  }
  else {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:heroType];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:theCurrentScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //theCurrentScore = 0;
    [Score registerScore:[[NSUserDefaults standardUserDefaults] integerForKey:theCurrentScore]];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:theCurrentCoins];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //theCurrentCoins = 0;
    
    [StoreInventory giveAmount:COINS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH ofItem:COINS_CURRENCY_ITEM_ID];
    [StoreInventory giveAmount:HEAD_STARTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH ofItem:HEAD_START_GOOD_ITEM_ID];
    [StoreInventory giveAmount:SUPER_HEAD_STARTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH ofItem:SUPER_HEAD_START_GOOD_ITEM_ID];
    [StoreInventory giveAmount:FINAL_BLASTS_TO_GIVE_THE_USER_ON_FIRST_APP_LAUNCH ofItem:FINAL_BLAST_GOOD_ITEM_ID];
    
    [StoreInventory giveAmount:1 ofItem:CLOTHES_GOOD_01_ITEM_ID];
    [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_01_ITEM_ID];
    
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:kCountStartup]; // set this to 0 to show ad at first startup
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:kCountGameOver]; // set this to 0 to show ad at first game over
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // This is the first launch ever
    
  }
  
  // game center manager setup
  [[GameCenterManager sharedManager] setupManager];
  
  // Set GameCenter Manager Delegate
  [[GameCenterManager sharedManager] setDelegate:self];
  
  // setup Flurry
  [self setupFlurry];
  
}

- (void) setupPlistFileData {
  [PlistManager setupPlistValues];
  
  //CUSTOM_SECRET = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaCustomSecret];
  //COIN_BOOSTER_PACK_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinBoosterPackID];
  //COIN_MEGA_PACK_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinMegaPackID];
  //COIN_ULTRA_PACK_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinUltraPackID];
  //COIN_IMPOSSIBLE_PACK_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinImpossiblePackID];
  //COIN_ULTIMATE_PACK_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPCoinUltimatePackID];
  //X2_COINS_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPDoubleCoinsID];
  //REVEAL_SECRET_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPRevealSecretID];
  //NO_ADS_IAP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kSoomlaIAPNoAdsID];
  
  //CHARTBOOST_APP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kChartboostAppID];
  //CHARTBOOST_APP_SIGNATURE = [PlistManager getStringValueFromNSUserDefaultsWithKey:kChartboostAppSignature];
  //SHOW_CHARTBOOST_INTERSTITIAL_AT_STARTUP = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kChartboostShowAdAtStartup];
  //SHOW_CHARTBOOST_INTERSTITIAL_AT_GAME_OVER = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kChartboostShowAdAtGameOver];
  
  //REVMOB_APP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobMediaID];
  //SHOW_REVMOB_INTERSTITIAL_AT_STARTUP = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kRevMobShowAdAtStartup];
  //SHOW_REVMOB_INTERSTITIAL_AT_GAME_OVER = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kRevMobShowAdAtGameOver];
  //REVMOB_INTERSTITIAL_AT_STARTUP_PLACEMENT_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobStartupPlacemetID];
  //REVMOB_INTERSTITIAL_AT_GAME_OVER_PLACEMENT_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobGameOverPlacementID];
  
  //VUNGLE_APP_ID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kVungleAppID];
  //SHOW_VUNGLE_AD_AT_STARTUP = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kVungleShowAdAtStartup];
  //SHOW_VUNGLE_AD_AT_GAME_OVER = [PlistManager getBoolValueFromNSUserDefaultsWithKey:kVungleShowAdAtGameOver];
  
  //GC_LEADERBOARD = [PlistManager getStringValueFromNSUserDefaultsWithKey:kGameCenterLeaderboardID];
  
  //FLURRY_API_KEY = [PlistManager getStringValueFromNSUserDefaultsWithKey:kFlurryAPIKey];
  
  //ADS_FREQUENCY_STARTUP = [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyStartup];
  //ADS_FREQUENCY_GAME_OVER = [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyGameOver];
  
  //NEXTPEER_GAME_KEY = [PlistManager getStringValueFromNSUserDefaultsWithKey:kNextpeerGameKey];
}

- (void) setupFlurry {
  
  // crash reporting
  // note: iOS only allows one crash reporting tool per app; if using another, set to: NO
  [Flurry setCrashReportingEnabled:YES];
  
  // start the Flurry Analytics session
  [Flurry startSession:[PlistManager getStringValueFromNSUserDefaultsWithKey:kFlurryAPIKey]];
}


- (void) setupiRate {
  
  //enable preview mode
  [iRate sharedInstance].previewMode = IRATE_ENABLE_PREVIEW_MODE;
  
  if (IRATE_ENABLE_PREVIEW_MODE) {
    [iRate sharedInstance].appStoreID = IRATE_TEST_APP_ID;
    [iRate sharedInstance].applicationBundleID = IRATE_TEST_APP_BUNDLE_ID;
  }
  
  //configure iRate
  [iRate sharedInstance].daysUntilPrompt = IRATE_DAYS_UNTIL_PROMPT;
  [iRate sharedInstance].usesUntilPrompt = IRATE_USES_UNTIL_PROMPT;
  [iRate sharedInstance].onlyPromptIfLatestVersion = IRATE_ONLY_PROMPT_IF_LATEST_VERSION;
  [iRate sharedInstance].remindPeriod = IRATE_REMIND_PERIOD;
  
  //overriding the default iRate strings
  [iRate sharedInstance].messageTitle = NSLocalizedString(IRATE_MESSAGE_TITLE, @"iRate message title");
  [iRate sharedInstance].message = NSLocalizedString(IRATE_MESSAGE, @"iRate message");
  [iRate sharedInstance].cancelButtonLabel = NSLocalizedString(IRATE_CANCEL_BUTTON, @"iRate decline button");
  [iRate sharedInstance].remindButtonLabel = NSLocalizedString(IRATE_REMIND_BUTTON, @"iRate remind button");
  [iRate sharedInstance].rateButtonLabel = NSLocalizedString(IRATE_RATE_BUTTON, @"iRate accept button");
}

- (void)initializeNextpeer
{
  NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
                            
                            // Support orientation change for the dashboard notifications
                            [NSNumber numberWithBool:YES], NextpeerSettingSupportsDashboardRotation,
                            //  Place the in-game ranking display in the top-left of the screen and align it vertically, so as to not hide the scores.
                            [NSNumber numberWithInt:NPNotificationPosition_TOP_LEFT], NextpeerSettingNotificationPosition,
                            [NSNumber numberWithInt:NPRankingDisplayAlignmentHorizontal], NextpeerSettingRankingDisplayAlignment,
                            nil];
  
  
  [Nextpeer initializeWithProductKey:[PlistManager getStringValueFromNSUserDefaultsWithKey:kNextpeerGameKey] andSettings:settings andDelegates:
   [NPDelegatesContainer containerWithNextpeerDelegate:self tournamentDelegate:self]];
  
}

-(void)nextpeerDidTournamentStartWithDetails:(NPTournamentStartDataContainer *)tournamentContainer {
  // Add code that starts a tournament:
  // 1. Load scene
  // 2. Start game
  
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_MULTIPLAYER object:nil];
  
}


-(void)nextpeerDidTournamentEnd {
  // Add code that ends the current tournament
  // 1. Stop game and animations
  // 2. Release any unneeded resources
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  if ([Nextpeer handleOpenURL:url]) {
    return YES;
  }
  
  // Handle other possible URLS
  
  return NO;
}

- (void) setupChartboost {
  
  // Begin a user session.
  // Must not be dependent on user actions or any prior network requests.
  [Chartboost startWithAppId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kChartboostAppID] appSignature:[PlistManager getStringValueFromNSUserDefaultsWithKey:kChartboostAppSignature] delegate:self];
  
}

- (void) setupRevMob {
  
  [RevMobAds startSessionWithAppID:[PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobMediaID]];
  
}

- (void) setupVungle {
  NSString* appID = [PlistManager getStringValueFromNSUserDefaultsWithKey:kVungleAppID];
  VungleSDK* sdk = [VungleSDK sharedSDK];
  // start vungle publisher library
  [sdk startWithAppId:appID];
  
  [[VungleSDK sharedSDK] setDelegate:self];
}

- (void) dealloc {
  [[VungleSDK sharedSDK] setDelegate:nil];
}

- (void)vungleSDKwillShowAd {
  NSLog(@"Strating Vungle Ad.");
  
  // stoping background music
  //[Options stopBackgroundMusic];
}

- (void) vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
  NSLog(@"Exiting Vungle Ad..");
  // the Vungle SDK does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] resume];
  
  // restarting background music
  //[Options playBackgroundMusic];
  
}

- (void) vungleSDKwillCloseProductSheet:(id)productSheet {
  NSLog(@"Exiting Vungle Ad.");
  // the Vungle SDK does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] resume];
  
  // restarting background music
  //[Options playBackgroundMusic];
  
}


+ (void) showAdsAtStartup {
  
  NSInteger startupCount = [[NSUserDefaults standardUserDefaults] integerForKey:kCountStartup];
  
  // showing ads
  if (![StoreInventory getItemBalance:NO_ADS_ITEM_ID] >= 1) {
    
    if (startupCount % [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyStartup] == 0) {
      NSLog(@"Showing ad at Startup because Startup Count is: %li and Ads Frequency is: %i.", (long)startupCount, [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyStartup]);
      // showing ad
      
      
      // FLURRY LOG
      [Flurry logEvent:@"[Startup] Showing Ads."];
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kVungleShowAdAtStartup]) {
        NSLog(@"Showing Vungle ad...");
        // passing the ad to be shown by RootViewControllerInterface
        [[RootViewControllerInterface sharedManager] playVungleAd];
      }
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kChartboostShowAdAtStartup]) {
        NSLog(@"Showing Chartboost ad...");
        // Show an interstitial
        [Chartboost showInterstitial:CBLocationStartup];
        
        // Cache Startup interstitial
        if (![Chartboost hasInterstitial:CBLocationStartup]) {
          [Chartboost cacheInterstitial:CBLocationStartup];
        }
      }
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kRevMobShowAdAtStartup]) {
        NSLog(@"Showing RevMob ad...");
        // Show RevMob interstitial
        RevMobFullscreen *fullscreen = [[RevMobAds session] fullscreenWithPlacementId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobStartupPlacemetID]];
        [fullscreen showAd];
      }
      
    } else {
      NSLog(@"Not showing ad at Startup because Startup Count is: %li and Ads Frequency is: %i.", (long)startupCount, [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyStartup]);
    }
    
  } else {
    NSLog(@"Ads are off.");
  }
  
  startupCount++;
  [[NSUserDefaults standardUserDefaults] setInteger:startupCount forKey:kCountStartup];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
}

+ (void) showAdsAtGameOver {
  
  NSInteger gameOverCount = [[NSUserDefaults standardUserDefaults] integerForKey:kCountGameOver];
  
  // showing ads
  if (![StoreInventory getItemBalance:NO_ADS_ITEM_ID] >= 1) {
    
    if (gameOverCount % [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyGameOver] == 0) {
      NSLog(@"Showing ad at Game Over because Game Over Count is: %li and Ads Frequency is: %i.", (long)gameOverCount, [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyGameOver]);
      // showing ad
      
      // FLURRY LOG
      [Flurry logEvent:@"[Game Over] Showing Ads."];
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kVungleShowAdAtGameOver]) {
        NSLog(@"Showing Vungle ad...");
        // passing the ad to be shown by RootViewControllerInterface
        [[RootViewControllerInterface sharedManager] playVungleAd];
      }
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kChartboostShowAdAtGameOver]) {
        NSLog(@"Showing Chartboost ad...");
        // Show an interstitial
        [Chartboost showInterstitial:CBLocationGameOver];
        
        // Cache Startup interstitial
        if (![Chartboost hasInterstitial:CBLocationGameOver]) {
          [Chartboost cacheInterstitial:CBLocationGameOver];
        }
      }
      
      if ([PlistManager getBoolValueFromNSUserDefaultsWithKey:kRevMobShowAdAtGameOver]) {
        NSLog(@"Showing RevMob ad...");
        // Show RevMob interstitial
        RevMobFullscreen *fullscreen = [[RevMobAds session] fullscreenWithPlacementId:[PlistManager getStringValueFromNSUserDefaultsWithKey:kRevMobGameOverPlacementID]];
        [fullscreen showAd];
      }
      
    } else {
      NSLog(@"Not showing ad at Game Over because Game Over Count is: %li and Ads Frequency is: %i.", (long)gameOverCount, [PlistManager getIntValueFromNSUserDefaultsWithKey:kAdsFrequencyGameOver]);
    }
    
  } else {
    NSLog(@"Ads are off.");
  }
  
  gameOverCount++;
  [[NSUserDefaults standardUserDefaults] setInteger:gameOverCount forKey:kCountGameOver];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
}

- (void) startMultiPlayerGame: (NSNotification *) notification
{
  CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
  [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) goodBalanceChanged {
  NSLog(@"Item purchased.");
}

- (void) alertUnexpectedErrorInStore {
  
  // FLURRY LOG
  [Flurry logEvent:@"[IAP] Purchase: Something Went Wrong!"];
  
  //[SVProgressHUD showErrorWithStatus:@"Something Went Wrong!"];
  [ProgressHUD showError:@"Something Went Wrong!"];
  
  // the Soomla iOS Store does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] setAnimationInterval:1.0/60];
  [[CCDirector sharedDirector] startAnimation];
}

- (void) alertTransactionRestoreStarted {
  //[SVProgressHUD showWithStatus:@"Restoring Your Purchases"];
  [ProgressHUD show:@"Restoring Your Purchases"];
}

- (void) alertTransactionRestoreFinished {
  
  // FLURRY LOG
  [Flurry logEvent:@"[IAP] Purchases Restored!"];
  
  //[SVProgressHUD showSuccessWithStatus:@"Restoring Finished!"];
  [ProgressHUD showSuccess:@"Restoring Finished!"];
  
  // the Soomla iOS Store does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] setAnimationInterval:1.0/60];
  [[CCDirector sharedDirector] startAnimation];
  
}

- (void) alertAppStorePurchaseStarted {
  //[SVProgressHUD showWithStatus:@"Purchasing..."];
  [ProgressHUD show:@"Purchasing..."];
}

- (void) alertAppStorePurchased {
  
  // FLURRY LOG
  [Flurry logEvent:@"[IAP] Purchase completed."];
  
  //[SVProgressHUD showWithStatus:@"Purchased..."];
  //[SVProgressHUD showSuccessWithStatus:@"Purchased..."];
  [ProgressHUD showSuccess:@"Purchased..."];
  
  // the Soomla iOS Store does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] setAnimationInterval:1.0/60];
  [[CCDirector sharedDirector] startAnimation];
}

- (void) alertAppStorePurchaseCanceled {
  
  // FLURRY LOG
  [Flurry logEvent:@"[IAP] Purchase canceled."];
  
  //[SVProgressHUD showErrorWithStatus:@"Purchase Canceled!"];
  [ProgressHUD showError:@"Purchase Canceled!"];
  
  // the Soomla iOS Store does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] setAnimationInterval:1.0/60];
  [[CCDirector sharedDirector] startAnimation];
}

+(UIImage*) screenshotWithStartNode:(CCNode*)startNode
{
  [CCDirector sharedDirector].nextDeltaTimeZero = YES;
  
  //CGSize viewSize = [[CCDirector sharedDirector] viewSize];
  //CCRenderTexture* rtx =
  //[CCRenderTexture renderTextureWithWidth:viewSize.width
  //                                 height:viewSize.height];
  
  CCRenderTexture* rtx =
  //[CCRenderTexture renderTextureWithWidth:568
  //height:384];
  [CCRenderTexture renderTextureWithWidth:384
                                   height:568];
  [rtx begin];
  [startNode visit];
  [rtx end];
  
  return [rtx getUIImage];
}

+ (void) captureScreenshot {
  
  NSLog(@"Saving Screenshot.");
  
  CCScene *scene = [[CCDirector sharedDirector] runningScene];
  CCNode *n = [scene.children objectAtIndex:0];
  UIImage *myImage = [AppController screenshotWithStartNode:n];
  
  // only for testing purposes
  //UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
  
  if (myImage != nil)
  {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"screenshot.png" ];
    NSData* data = UIImagePNGRepresentation(myImage);
    [data writeToFile:path atomically:YES];
  }
  
}

+ (void) deleteScreenshot {
  
  // getting saved screenshot
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString* path = [documentsDirectory stringByAppendingPathComponent:
                    @"screenshot.png" ];
  //deleting screenshot
  NSError *error = nil;
  
  if (path != nil) {
    NSLog(@"Deleting Screenshot.");
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
  } else {
    NSLog(@"No Screenshot found.");
  }
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Manager Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
  /*
   [self presentViewController:gameCenterLoginController animated:YES completion:^{
   NSLog(@"Finished Presenting Authentication Controller");
   }];*/
  
  [[RootViewControllerInterface sharedManager] presentViewController:gameCenterLoginController animated:YES];
}

- (void)gameCenterManager:(GameCenterManager *)manager error:(NSError *)error {
  NSLog(@"GCM Error: %@", error);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Center" message:@"Sorry. Something went wrong." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
  [alert show];
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedScore:(GKScore *)score withError:(NSError *)error {
  if (!error) {
    NSLog(@"GCM Reported Score.");
    
  } else {
    NSLog(@"GCM Error while reporting score: %@", error);
  }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveScore:(GKScore *)score {
  NSLog(@"Saved GCM Score.");
  
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedAchievement:(GKAchievement *)achievement withError:(NSError *)error
{
  if (!error) {
    NSLog(@"GCM Reported Achievement.");
    
  } else {
    NSLog(@"GCM Error while reporting achievement: %@", error);
  }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveAchievement:(GKAchievement *)achievement {
  NSLog(@"Saved GCM Achievement with ID.");
}


@end
