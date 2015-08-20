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
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "Options.h"

@interface AppController ()
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
  
  //set sound ON
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFXState];
  
  
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

- (void) startMultiPlayerGame: (NSNotification *) notification
{
  CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
  [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) goodBalanceChanged {
  NSLog(@"Item purchased.");
}

- (void) alertUnexpectedErrorInStore {
  
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
  
  //[SVProgressHUD showWithStatus:@"Purchased..."];
  //[SVProgressHUD showSuccessWithStatus:@"Purchased..."];
  [ProgressHUD showSuccess:@"Purchased..."];
  
  // the Soomla iOS Store does NOT restart the cocos2d animations
  // we need to restart them manually here
  [[CCDirector sharedDirector] setAnimationInterval:1.0/60];
  [[CCDirector sharedDirector] startAnimation];
}

- (void) alertAppStorePurchaseCanceled {
  
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




@end
