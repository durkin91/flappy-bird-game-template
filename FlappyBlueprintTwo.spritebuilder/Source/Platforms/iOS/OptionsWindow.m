//
//  OptionsWindow.m
//  FlappyBlueprintTwo
//
//  Created by Nikki Durkin on 8/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OptionsWindow.h"
#import "Options.h"

@implementation OptionsWindow {
    CCButton *_toggleSoundOnButton;
    CCButton *_toggleSoundOffButton;
}

- (void)didLoadFromCCB {
    
    //Setup the sound button
    if ([Options getFXState] == TRUE) {
        _toggleSoundOffButton.visible = YES;
        _toggleSoundOnButton.visible = NO;
    }
    
    else {
        _toggleSoundOnButton.visible = YES;
        _toggleSoundOffButton.visible = NO;
    }
}

- (void) toggleSoundOffButtonTapped {
    
    NSLog(@"Sound is OFF.");
    [Options registerFXState:NO];
    
    _toggleSoundOffButton.visible = NO;
    _toggleSoundOnButton.visible = YES;
    
}

- (void) toggleSoundOnButtonTapped {
    
    NSLog(@"Sound is ON.");
    [Options registerFXState:YES];
    
    _toggleSoundOnButton.visible = NO;
    _toggleSoundOffButton.visible = YES;
    
}


- (void)okButtonTapped {
    
    [self.delegate okButtonTapped];
    
}

@end
