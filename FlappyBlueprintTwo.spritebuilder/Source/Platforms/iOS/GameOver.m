//
//  GameOver.m
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

#import "GameOver.h"
#import "Score.h"
#import "Defaults.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "RootViewControllerInterface.h"
#import "AppDelegate.h"
#import "Options.h"

#import "PlistManager.h"

@implementation GameOver {
    CCLabelBMFont *_currentScoreLabel;
    NSUInteger currentScore;
    NSString *currentScoreString;
    
    CCLabelBMFont *_bestScoreLabel;
    NSUInteger bestScore;
    NSString *bestScoreString;
    
    CCSprite *_newBestScore;
    
    CCLabelBMFont *_currentCoinsLabel;
    NSUInteger currentCoins;
    NSString *currentCoinsString;
    
    CCLabelBMFont *_allCoinsLabel;
    NSUInteger allCoins;
    NSString *allCoinsString;

}

- (void)didLoadFromCCB {
    
    
  if ([[NSUserDefaults standardUserDefaults] boolForKey:isNewBestScore]) {
        
        //showing new best score badge;
        _newBestScore.visible = YES;
        
    } else {
        _newBestScore.visible = NO;
    }
    
    _newBestScore.zOrder = GameOverZeeOrderNewBest;
    
    [self addScoreLabel];
    [self addBestScoreLabel];
    
    [self addCurrentCoinsLabel];
    [self addAllCoinsLabel];
}

- (void) onExit {
  
  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isNewBestScore];
  [[NSUserDefaults standardUserDefaults] synchronize];

  
    //isNewBestScore = NO;
    [super onExit];
}

- (void) addScoreLabel {
    currentScore = [Score currentScore];
    currentScoreString = [NSString stringWithFormat:@"%li",(long)currentScore];
    
    _currentScoreLabel = [CCLabelBMFont labelWithString:currentScoreString fntFile:@"MyAwesomeBMFont.fnt"];
    _currentScoreLabel.anchorPoint = ccp(0.5, 0.5);
    _currentScoreLabel.position = ccp(130, 250);
    _currentScoreLabel.scale = 0.7f;
    
    [self addChild:_currentScoreLabel];
}

- (void) addBestScoreLabel {
    bestScore = [Score bestScore];
    bestScoreString = [NSString stringWithFormat:@"%li",(long)bestScore];
    
    _bestScoreLabel = [CCLabelBMFont labelWithString:bestScoreString fntFile:@"MyAwesomeBMFont.fnt"];
    _bestScoreLabel.anchorPoint = ccp(0.5, 0.5);
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:isNewBestScore]) {
        _bestScoreLabel.position = ccp(260, 275);
    } else {
        _bestScoreLabel.position = ccp(260, 250);
    }
    
    _bestScoreLabel.scale = 0.7f;
    _bestScoreLabel.zOrder = GameOverZeeOrderBestScore;
    
    [self addChild:_bestScoreLabel];
}

- (void) addCurrentCoinsLabel {
    currentCoins = [Score currentCoins];
    currentCoinsString = [NSString stringWithFormat:@"%li",(long)currentCoins];
    
    _currentCoinsLabel = [CCLabelBMFont labelWithString:currentCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _currentCoinsLabel.anchorPoint = ccp(0.5, 0.5);
    _currentCoinsLabel.position = ccp(130, 370);
    _currentCoinsLabel.scale = 0.7f;
    
    [self addChild:_currentCoinsLabel];
}

- (void) addAllCoinsLabel {
    allCoins = [StoreInventory getItemBalance:COINS_CURRENCY_ITEM_ID];
    allCoinsString = [NSString stringWithFormat:@"%li",(long)allCoins];
    
    _allCoinsLabel = [CCLabelBMFont labelWithString:allCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _allCoinsLabel.anchorPoint = ccp(0.5, 0.5);
    _allCoinsLabel.position = ccp(260, 370);
    _allCoinsLabel.scale = 0.7f;
    
    [self addChild:_allCoinsLabel];
}


- (void) homeButtonTapped {
    
    [Options playTapSound];
    
    [AppController deleteScreenshot];
    
    CCScene *homeScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:homeScene];
}

- (void) shareButtonTapped {
    [Options playTapSound];
    [[RootViewControllerInterface sharedManager] presentUIActivityViewControllerWithCurrentScoreInString:currentScoreString];
}

- (void) shopButtonTapped {
    
    [Options playTapSound];
    
    [AppController deleteScreenshot];
    
    CCScene *shopScene = [CCBReader loadAsScene:@"ShopMenu"];
    [[CCDirector sharedDirector] replaceScene:shopScene];
}

@end
