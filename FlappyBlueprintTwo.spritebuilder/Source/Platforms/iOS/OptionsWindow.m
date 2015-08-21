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
    CCButton *_toggleSoundOnOffButton;
}

- (void) toggleSoundOnOffButtonTapped:(id) sender {
    
    [Options playTapSound];
    
    _toggleSoundOnOffButton = sender;
    
    if (_toggleSoundOnOffButton.selected)
    {
        NSLog(@"Sound is OFF.");
        //[Options stopBackgroundMusic];
        [Options registerFXState:NO];
    }
    else
    {
        NSLog(@"Sound is ON.");
        [Options registerFXState:YES];
        //[Options playBackgroundMusic];
    }
    
}

- (void)okButtonTapped {
    
    [self.delegate okButtonTapped];
    
}

@end
