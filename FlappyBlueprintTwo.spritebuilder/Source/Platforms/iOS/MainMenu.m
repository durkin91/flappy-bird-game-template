//
//  MainMenu.m
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

#import "MainMenu.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "RootViewControllerInterface.h"
#import "AppDelegate.h"
#import "Options.h"
#import "SelectDifficultyPanel.h"
#import "Data.h"

@implementation MainMenu {
    CCButton *_toggleSoundOnOffButton;
    NSUInteger allCoins;
    NSString *allCoinsString;
    CCButton *_playButton;
    CCButton *_optionsButton;
    OptionsWindow *_optionsMenu;
    CCNode *_darkOverlay;
    CCButton *_infoButton;
    SelectDifficultyPanel *_selectDifficultyPanel;
    CCNodeGradient *_gradientNode;
}

- (void)didLoadFromCCB {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasLaunchedOnce"];
    
    _optionsMenu.delegate = self;
    
    [self animatePlayButton];
    
    //Set up gradient node with correct color scheme
    _gradientNode.startColor = [Data startColorForGradientNode];
    _gradientNode.endColor = [Data endColorForGradientNode];
    
}


- (void) playButtonTapped {
    
    [Options playTapSound];
    
    [self showLevelDifficultyPanel];
}


- (void) optionsButtonTapped {
    
    [Options playTapSound];
    
    [self animateOptionsButton];
    [self showOptionsMenu];
    
}

- (void) infoButtonTapped {
    
    [Options playTapSound];
    
    CCScene *scene = [CCBReader loadAsScene:@"Info"];
    [[CCDirector sharedDirector] replaceScene:scene];
}



#pragma mark - animations

- (void)animatePlayButton {
    
    float duration = 1.0;
    CCActionScaleTo *scaleDown = [CCActionScaleTo actionWithDuration:duration scale:0.95];
    CCActionScaleTo *scaleUp = [CCActionScaleTo actionWithDuration:duration scale:1.0];
    CCActionSequence *sequence = [CCActionSequence actions:scaleDown, scaleUp, nil];
    CCActionRepeatForever *repeat = [CCActionRepeatForever actionWithAction:sequence];
    
    [_playButton runAction:repeat];
    
}

- (void)animateOptionsButton {
    
    float duration = 0.3;
    CCActionRotateBy *rotate = [CCActionRotateBy actionWithDuration:duration angle:360 * 8];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:duration];
    CCActionSpawn *spawn = [CCActionSpawn actions:rotate, fadeOut, nil];
    
    _optionsButton.cascadeOpacityEnabled = YES;
    [_optionsButton runAction:spawn];
}

- (void)returnOptionsButton {
    
    float duration = 0.3;
    CCActionRotateBy *rotate = [CCActionRotateBy actionWithDuration:duration angle:360 * 8];
    CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:duration];
    CCActionSpawn *spawn = [CCActionSpawn actions:rotate, fadeIn, nil];
    
    _optionsButton.cascadeOpacityEnabled = YES;
    [_optionsButton runAction:spawn];
}

- (void)prepareForOverlayDisplay {
    
    [_darkOverlay runAction:[CCActionFadeTo actionWithDuration:0.3 opacity:0.5]];
    
    _playButton.enabled = NO;
    _infoButton.enabled = NO;
}

- (void)prepareForOverlayRemoval {
    
    [_darkOverlay runAction:[CCActionFadeTo actionWithDuration:0.3 opacity:0]];
    
    _playButton.enabled = YES;
    _infoButton.enabled = YES;
    
}

#pragma mark  - Option Panel

- (void) okButtonTapped {
    
    [Options playTapSound];
    
    [self returnOptionsButton];
    [self hideOptionsMenu];
}

- (void)showOptionsMenu {
    
    [self prepareForOverlayDisplay];
    _optionsMenu.visible = YES;
    
}

- (void)hideOptionsMenu {
    
    [self prepareForOverlayRemoval];
    _optionsMenu.visible = NO;
    
}

#pragma mark - Level Difficulty panel

- (void)showLevelDifficultyPanel {
    
    [self prepareForOverlayDisplay];
    _optionsButton.enabled = NO;
    
    _selectDifficultyPanel.visible = YES;
    
}

@end
