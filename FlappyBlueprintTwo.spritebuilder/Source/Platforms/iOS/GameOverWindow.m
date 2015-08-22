//
//  GameOverWindow.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOverWindow.h"
#import "Score.h"
#import "Defaults.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "RootViewControllerInterface.h"
#import "AppDelegate.h"
#import "Options.h"

#import "PlistManager.h"

@implementation GameOverWindow {
    
    CCLabelBMFont *_currentScoreLabel;
    NSUInteger currentScore;
    NSString *currentScoreString;
    
    CCLabelBMFont *_bestScoreLabel;
    NSUInteger bestScore;
    NSString *bestScoreString;
    
    CCSprite *_newBestScore;
    CCSprite *_highScoreCoinIcon;
    
}



- (void) onExit {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isNewBestScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //isNewBestScore = NO;
    [super onExit];
}

- (void) updateScores {
    [self addScoreLabel];
    [self addBestScoreLabel];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:isNewBestScore]) {
        
        //showing new best score badge;
        _newBestScore.visible = YES;
        [self animateCoinForNewBestScore];
        
    } else {
        _newBestScore.visible = NO;
    }
}

- (void) addScoreLabel {
    currentScore = [Score currentScore];
    currentScoreString = [NSString stringWithFormat:@"%li",(long)currentScore];
    _currentScoreLabel.string = currentScoreString;
}

- (void) addBestScoreLabel {
    bestScore = [Score bestScore];
    bestScoreString = [NSString stringWithFormat:@"%li",(long)bestScore];
    _bestScoreLabel.string = bestScoreString;
}

- (void) homeButtonTapped {
    
    [Options playTapSound];
    
    [AppController deleteScreenshot];
    
    CCScene *homeScene = [CCBReader loadAsScene:@"MainMenu"];
    [[CCDirector sharedDirector] replaceScene:homeScene];
}

- (void) replayButtonTapped {
    
    [Options playTapSound];
    
    [AppController deleteScreenshot];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}

- (void) infoButtonTapped {
    
    [Options playTapSound];
    
    CCScene *scene = [CCBReader loadAsScene:@"Info"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void) animateCoinForNewBestScore {
    
    NSTimeInterval shakeDuration = 0.1;
    NSInteger angle = 10;
    float currentScale = _highScoreCoinIcon.scale;
    
    CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.2 scale:currentScale * 1.15];
    CCActionSequence *shake = [CCActionSequence actions:[CCActionRotateBy actionWithDuration:shakeDuration angle:angle * -1], [CCActionRotateBy actionWithDuration:shakeDuration angle:angle], [CCActionRotateBy actionWithDuration:shakeDuration angle:angle * -1], [CCActionRotateBy actionWithDuration:shakeDuration angle:angle], nil];
    CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.2 scale:currentScale];
    CCActionSequence *sequence = [CCActionSequence actions:grow, shake, shrink, nil];
    
    [_highScoreCoinIcon runAction:sequence];
    
}

@end
