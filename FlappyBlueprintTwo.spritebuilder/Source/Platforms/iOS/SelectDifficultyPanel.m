//
//  SelectDifficultyPanel.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SelectDifficultyPanel.h"
#import "Defaults.h"
#import "Options.h"

@implementation SelectDifficultyPanel

- (void) easyButtonTapped {
    
    [Options playTapSound];
    
    [[NSUserDefaults standardUserDefaults] setObject:kEASY_DIFFICULTY forKey:GAME_DIFFICULTY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self play];
    
}

- (void) mediumButtonTapped {
    
    [Options playTapSound];
    
    [[NSUserDefaults standardUserDefaults] setObject:kMEDIUM_DIFFICULTY forKey:GAME_DIFFICULTY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self play];
    
}

- (void) hardButtonTapped {
    
    [Options playTapSound];
    
    [[NSUserDefaults standardUserDefaults] setObject:kHARD_DIFFICULTY forKey:GAME_DIFFICULTY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self play];
    
}

- (void) play {
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}

@end
